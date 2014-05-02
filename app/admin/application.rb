ActiveAdmin.register Application do
  actions :index, :show, :edit, :update

  permit_params :tag_list, :flagged, :junk, :status
  
  scope_to :current_user, :association_method => :like_apps, :unless => :current_admin_user

  filter :taggings_tag_name, :label => "Tags", :as => :select,
         :collection => proc {
            if current_admin_user
              ActsAsTaggableOn::Tag.all.map{ |t| [t.name, t.name] }.compact
            else
              ActsAsTaggableOn::Tag.all.map{ |t| [t.name, t.name] if current_user.tag_list.include? t.name }.compact
            end
          }
  filter :flagged
  filter :junk
  filter :name
  filter :salesforce_id, :label => "Salesforce ID"


  index do
    column :id
    column :name
    column :remote_source
    column "Reviews" do |app|
      app.reviews.size
    end
    column :flagged
    column :junk
    column :status do |app|
      app.status.titleize
    end
    default_actions
  end


  show do |app|
    h5 app.fancy_tag_list

    h3 link_to "Review Application", new_admin_application_review_path(app), :class => 'review_button'
    h3 link_to "Mark as Junk", mark_junk_path(app), :class => 'mark_junk' unless app.junk?
    br

    attributes_table do
      row :id
      row :status
      row :created_at
      row :details
    end

    h3 link_to "Review Application", new_admin_application_review_path(app), :class => 'review_button'
    h3 link_to "Mark as Junk", mark_junk_path(app), :class => 'mark_junk' unless app.junk?

  end

  form do |f|
    f.inputs "Application Details" do
      if current_admin_user
        f.input :junk
        f.input :flagged
        f.input :status
      end

      f.input :tag_list, :as => :check_boxes,
                                 :multiple => :true,
                                 :label => "Tags",
                                 :collection => Application::BUCKETS.collect { |b| b[0].to_s.titleize }

    end

    f.actions
  end


  controller do
    def update
      app = Application.find(params[:id])
      app.tag_list = params[:application][:tag_list].join(", ")
      app.save

      super
    end

  end

end