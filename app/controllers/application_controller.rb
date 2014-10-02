class ApplicationController < ActionController::Base
  protect_from_forgery

  include PublicActivity::StoreController

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :current_user_is
  helper_method :current_admin_user

  ensure_security_headers(
    :hsts => {:max_age => 631138519, :include_subdomains => false},
    :x_frame_options  => {:value => 'SAMEORIGIN'},
    :x_xss_protection => {:value => 1, :mode => 'block'},
    :x_content_type_options => {:value => 'nosniff'},
    :csp => false
  )
  def access_denied

  end

  # private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def current_admin_user
      if current_user && [:admin].any? {|r| current_user.has_role?(r)}
        current_user
      end
    end

    def current_sme_user
      if current_user && [:admin, :SME].any? {|r| current_user.has_role?(r)}
        current_user
      end
    end

    def current_keymaster_user
      if current_user && [:keymaster].any? {|r| current_user.has_role?(r) }
        current_user
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def current_user_is(role)
      return true if current_user && current_user.has_role?(role)
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to signin_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def authenticate_admin_user!
      if current_user
        if !current_admin_user
          redirect_to root_url, :alert => 'You are not authorized to access this page.'
        end
      else
        redirect_to signin_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def authenticate_sme_user!
      if current_user
        if !current_sme_user
          redirect_to root_url, :alert => 'You are not authorized to access this page.'
        end
      else
        redirect_to signin_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def authenticate_keymaster_user!
      if current_user
        if !current_keymaster_user
          redirect_to root_url, :alert => 'You are not authorized to access this page.'
        end
      else
        redirect_to signin_urel, :alert => 'You need to sign in for access to this page.'
      end
    end

    def sf_client
      @sfclient ||= Restforce.new(:host => ENV['SALESFORCE_HOST'])
    end

    def redirect_to_back(default = root_url)
      if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
        redirect_to :back
      else
        redirect_to default
      end
    end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

end
