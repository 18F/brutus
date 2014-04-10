ActiveAdmin.register Application do
  actions :index, :show

  filter :tags
  filter :flagged
  filter :junk

  controller do
    def resource
      Application.where(: params[:id]).first!
    end
  end

  index do
    h3 link_to "Developer", "#"
    column :id
    column :name
    column :remote_source
    column "Reviews" do |app|
      app.reviews.size
    end
    column :flagged? do |app|
      if app.flagged?
        "Yes"
      else
        "No"
      end
    end
    column :junk
    default_actions
  end


  show do |app|
    h3 link_to "Review Application", new_admin_application_review_path(app), :class => 'review_button'
    h3 link_to "Mark as Junk", mark_junk_path(app), :class => 'mark_junk' unless app.junk?
    br
    
    attributes_table do
      row :id
      row :status
      row :created_at
      row :details
    end

    # default_actions
    h3 link_to "Review Application", new_admin_application_review_path(app), :class => 'review_button'
    h3 link_to "Mark as Junk", mark_junk_path(app), :class => 'mark_junk' unless app.junk?
    # active_admin_comments
  end

end