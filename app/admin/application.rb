ActiveAdmin.register Application do
  # permit_params :body, :alert_type_id, :subject, :zip, :is_parent, :gender

  preserve_default_filters!

  index do
    column :id
    column :name
    column :remote_source
    column "Reviews" do |app|
      app.reviews.size
    end
    # column "Flagged?" do |app|
    #   app.flagged?
    # end
    column :flagged?

    default_actions
  end


  show do |app|
    h3 "Application Details"
    attributes_table do
      # row :subject
      # row :body
      # row :alert_type
      # row :sent_at
      # row :subscribers do
      #   ul do
      #     alert.subscribers.each do |sub|
      #       li link_to(sub.name, admin_user_path(sub))
      #     end
      #     li "None" if alert.subscribers.empty?
      #   end
      # end
    end
  end


end
