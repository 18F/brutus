ActiveAdmin.register Review do
  actions :index, :show, :new, :create

  belongs_to :application

  permit_params :score, :remarks, :follow_up

  filter :tags
  filter :flagged

  config.comments = true

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


  controller do
    after_filter :assign_user, :only => :create

    def assign_user
      @review.user_id = current_user.id
      @review.save
    end
  end
end