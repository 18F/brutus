ActiveAdmin.register User do
  permit_params :email, :agency_id, :roles

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :agency, as: :select, collection: Agency.all
    end
    if current_admin_user
      f.inputs "Roles" do
        f.input :roles, :as => :check_boxes
      end
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
      row :tag_list do |user|
        ul do
          user.tags.each do |tag|
            li tag.name
          end
        end
      end
    end

    # active_admin_comments
  end


  controller do
    before_filter :check_access, :only => [:show, :edit, :update, :destroy]

    def scoped_collection
      resource_class.includes(:roles)
    end

    def update
      if current_admin_user
        user = User.find(params[:id])

        # update roles to match checkboxes
        role_ids = params[:user][:role_ids]
        user.roles.clear()
        user.roles << role_ids.select{|id| !id.empty? }.map{|id| Role.find(id)}
      end

      super
    end

    def check_access
      correct_user? unless current_admin_user
    end
  end
end
