ActiveAdmin.register Application do
  actions :index, :show

  # controller do
  #   before_filter :fetch_app, :only => [:show]

  #   def fetch_app
  #     @app = Application.find(params[:id])
  #     @sf_app = SF_CLIENT.select(ENV['SALESFORCE_APP_OBJECT'], @app.remote_key, Rails.cache.read('SALESFORCE_FIELDS'))
  #   end
  # end

  filter :tags
  filter :flagged

  index do
    column :id
    column :name
    column :remote_source
    column "Reviews" do |app|
      app.reviews.size
    end
    column :flagged?

    default_actions
    # column "Actions" do |u|
    #   link_to "Review", "/review"
    #   # if can? :read, u
    #   #    link_to "View", admin_user_path(u)
    #   # end
    # end
  end


  show do |app|
    h3 link_to "Review Application", new_admin_application_review_path(app)
    # h3 "Application Details"
    attributes_table do
      row :id
      row :status
      row :created_at
      row :details
    end

    # default_actions
    h3 link_to "Review Application", new_admin_application_review_path(app)

    active_admin_comments
  end

  # form do |f|
  #   f.inputs "Review" do

  #   end
  # end
#   form do |f|
#     f.inputs "User Details" do
#       f.input :name
#       f.input :email
#       f.input :agency, as: :select, :required => true if user.has_role? :agency_admin end
#       f.inputs "Roles" do
#         f.input :roles, :as => :check_boxes
#       end
#     f.actions
#   end
  # end


end


# ActiveAdmin.register User do
#   scope_to :current_agency, :unless => proc{ current_user.has_role? :admin }
#   permit_params :email

#   index do
#     column :email
#     column :current_sign_in_at
#     column :last_sign_in_at
#     column :sign_in_count
#     default_actions
#   end

#   filter :email

#   form do |f|
#     f.inputs "User Details" do
#       f.input :name
#       f.input :email
#       f.input :agency, as: :select, :required => true if user.has_role? :agency_admin end
#       f.inputs "Roles" do
#         f.input :roles, :as => :check_boxes
#       end
#     f.actions
#   end

#   show do |user|
#     h3 user.name
#     attributes_table do
#       row :id
#       row :uid
#       row :email
#       row :agency
#       row :zip
#       row :gender
#       row :is_parent
#       row :created_at
#       row :updated_at
#       row :roles do |user|
#         user.roles.map{|r| r.name.titleize()}.join(', ').html_safe
#       end
#     end
#     active_admin_comments
#   end


#   controller do
#     def permitted_params
#       params.permit(:user => [:id, :name, :email, :agency_id, :roles])
#     end

#     def scoped_collection
#       resource_class.includes(:roles)
#     end

#     def update
#       user = User.find(params[:id])

#       # update roles to match checkboxes
#       role_ids = params[:user][:role_ids]
#       user.roles.clear()
#       user.roles << role_ids.select{|id| !id.empty? }.map{|id| Role.find(id)}

#       super
#     end
#   end
# end
