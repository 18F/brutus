ActiveAdmin.register Review do
  actions :index, :show, :new, :create

  belongs_to :application

  permit_params :score, :remarks, :follow_up

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
      row :score
      row :follow_up
      row :remarks
    end
  end

  form :partial => "form"

  # form do |f|
  #   f.inputs "Review" do
  #     f.input :user_id, :type => "hidden", :value => current_user.id
  #     f.input :application_id, :as => "hidden", :value => @app.id
  #     f.input :score
  #     f.input :remarks
  #     f.input :follow_up

  #     # h5 :app_details
  #   end

  #   f.actions
  # end


  controller do
    # before_filter :query_application, :only => [:new]

    # def query_application
    #   @app = Application.find(params[:application_id])
    # end

    def create
      params[:review][:user_id] = current_user.id
      super
    end
  end
end