ActiveAdmin.register User do
  permit_params :email

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :email
      f.input :agency, as: :select, collection: AGENCIES
    end
    f.inputs "Roles" do
      f.input :roles, :as => :check_boxes
    end
    f.actions
  end

  show do |user|
    h3 user.name
    attributes_table do
      row :id
      row :uid
      row :email
      row :agency
      row :created_at
      row :updated_at
      row :roles do |user|
        user.roles.map{|r| r.name.capitalize()}.join(', ').html_safe
      end
    end
  end


  controller do
    def permitted_params
      params.permit(:user => [:id, :name, :email, :agency, :roles])
    end

    def scoped_collection
      resource_class.includes(:roles)
    end

    def update
      user = User.find(params[:id])

      # update roles to match checkboxes
      role_ids = params[:user][:role_ids]
      user.roles.clear()
      user.roles << role_ids.select{|id| !id.empty? }.map{|id| Role.find(id)}

      super
    end
  end
end
