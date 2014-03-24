ActiveAdmin.register Review do
  actions :index, :show, :new

  filter :tags
  filter :flagged

  index do
    column :id
    
    default_actions
    # column "Actions" do |u|
    #   link_to "Review", "/review"
    #   # if can? :read, u
    #   #    link_to "View", admin_user_path(u)
    #   # end
    # end
  end


  show do |review|
    h3 "Review Details"
    attributes_table do
      row :id
    end
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