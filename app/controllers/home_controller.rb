class HomeController < ApplicationController

  before_filter :authenticate_user!, :except => [:index]

  def index
    redirect_to admin_root_path if current_admin_user or current_sme_user
    @applications ||= Application.all
    @reviews ||= Review.all
    @users ||= User.all
    # @activities = PublicActivity::Activity.order(:created_at => :desc).limit(10)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # TODO move these to appropriate controllers
  def sync
    last_import = Import.last
    begin
      if last_import.nil? or last_import.created_at < 10.minutes.ago
        render :json => "Success! The Salesforce API will be syncronized momentarily.", :status => 200
        new_import = Import.create
        Resque.enqueue(SalesforceSyncJob, new_import.id)
      else
        render :json => "You are currently viewing up-to-date data, last synced: #{last_import.created_at}. Refresh your browser to view the latest data.", :status => 400
      end
    rescue Exception => e
      render :json => "I'm not sure what is going on.", :status => 200
      logger.error e
    end
  end

  # TODO 
  # cleanup and move these methods to appropriate controller
  def app_details
    @client ||= SF_CLIENT
    @sf_fields ||= Rails.cache.read('SALESFORCE_APP_OBJECT_FIELDS')
    @sf_field_metadata ||= Rails.cache.read('SALESFORCE_APP_OBJECT_FIELD_METADATA')
    @payload = { :fields => @sf_field_metadata, :projects => [] }
    @app = Application.find(params[:id])
    @app_detail = @client.query("select #{Rails.cache.read('SALESFORCE_APP_OBJECT_FIELDS').join(", ")} from PIF_Application__c where PIF_Contact__c = '#{@app.remote_key}'").entries.last
    @sf_projects = @client.query("select Id, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, PIF_Application__c, PIF_Project_Name__c, Project_Fit__c from PIF_Project__c where PIF_Application__c = '#{@app_detail['Id']}'")
    @project_detail = []
    @sf_projects.each do |project|
      @project_detail << { project['PIF_Project_Name__c'] => project['Project_Fit__c'] }
    end

    @payload[:application] = @app_detail
    @payload[:projects] = @project_detail

    render :json => @payload
  end

  def mark_junk
    @application = Application.find(params[:id])
    @application.junk = true
    if @application.save
      # redirect_to_back#, :alert => 'Marked as junk.'
      redirect_to admin_applications_path, :notice => 'Successfully marked as junk.'
    else
      flash[:error] = "Unable to mark as junk"
      redirect_to_back
    end
  end

  def flag_app
    @application = Application.find(params[:id])
    @application.flagged = true
    if @application.save
      redirect_to admin_applications_path, :notice => 'Successfully flagged application.'
    else
      flash[:error] = "Unable to flag application."
      redirect_to_back
    end
  end

  def fetch_flagged_apps
    @flagged_apps = Application.flagged(10,params[:tag_list])
    render :json => @flagged_apps.to_json(:methods => :tag_list)
  end

  def fetch_recent_apps
    @recent_apps = Application.recent(10,params[:tag_list])
    render :json => @recent_apps.to_json(:methods => :tag_list)
  end

  def fetch_recent_reviews
    @recent_reviews = Review.recent
    render :json => @recent_reviews.to_json(:methods => [ :reviewer, :applicant, :created_ago ])
  end

  def fetch_related_apps
    @related_apps = Application.find_related_tags(params[:tag_list])
    render :Json => @related_apps
  end
end
