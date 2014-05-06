ActiveAdmin.register SecondFactor, :as => "Two-Factor" do
  actions :index, :update, :edit

  permit_params :password, :password_confirmation, :active

  menu :label => "2FA", :if => proc{ current_user.has_role? :keymaster }

  config.filters = false

  index do
    column "Active" do |sf|
      if sf.active
        "True"
      else
        "False"
      end
    end

    default_actions
  end

  form do |f|
    f.inputs "Enable 2FA" do
      f.input :active
    end

    f.inputs "New Master Password" do
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end


  controller do
    before_filter :check_access, :only => [:index, :show, :edit, :update, :destroy]


    def update
      if params[:two_factor]
        unless params[:two_factor][:password].blank?
          if current_keymaster_user and sf = SecondFactor.find(params[:id])
            if valid_password = SecondFactor.validate_password(params[:two_factor])
              sf.encrypted_password = Digest::SHA2.hexdigest(valid_password)
            else
              redirect_to edit_admin_two_factor_path(sf), :notice => "Password does not meet complexity requirements."
              return
            end
            sf.save
          end
        end
        params[:two_factor].delete(:password)
        params[:two_factor].delete(:password_confirmation)
      end

      super
    end


    def check_access
      redirect_to root_url, :alert => "Access denied." unless current_user && current_user.has_role?(:keymaster)
    end
  end
end
