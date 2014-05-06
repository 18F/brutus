class SessionsController < ApplicationController

  def new
    redirect_to '/auth/myusa'
  end


  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'], 
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    # Reset the session after successful login, per
    # 2.8 Session Fixation – Countermeasures:
    # http://guides.rubyonrails.org/security.html#session-fixation-countermeasures
    reset_session
    if SecondFactor::active?
      session[:pending_user_id] = user.id
      session[:pending_auth] = auth
      redirect_to second_factor_path, :alert => "Please enter the second factor password to gain access to the application."
    else
      session[:user_id] = user.id
      user.log_sign_in(request.ip,auth)
      user.add_role :admin if User.count == 1 # make the first user an admin
      if user.email.blank?
        redirect_to edit_user_path(user), :alert => "Please enter your email address."
      else
        redirect_to root_url, :notice => 'Signed in!'
      end
    end
  end

  def destroy
    current_user.log_sign_out(request.ip) if current_user
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    message = params[:message] || "unknown"
    redirect_to root_url, :alert => "Authentication error: #{message.humanize}"
  end

  def second_factor
    redirect_to root_url, :alert => "Access denied." unless session[:pending_user_id] and session[:pending_auth]
    @second_factor = SecondFactor.active
    if @second_factor and params[:second_factor] and params[:second_factor][:password]
      if SecondFactor.active.encrypted_password == Digest::SHA2.hexdigest(params[:second_factor][:password])
        user = User.find(session[:pending_user_id])
        session[:user_id] = user.id
        user.log_sign_in(request.ip,session[:pending_auth])
        redirect_to root_url, :notice => "Signed in! Welcome!"
      else
        flash.now[:error] = 'Invalid password.'
      end
    end
  end
end
