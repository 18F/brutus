class HomeController < ApplicationController

  before_filter :authenticate_user!, :only => [:sync, :app_details]

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
  # cleanup
  def app_details
    @client ||= SF_CLIENT
    @sf_fields ||= Rails.cache.read('SALESFORCE_APP_OBJECT_FIELDS')
    @sf_labels ||= Rails.cache.read('SALESFORCE_APP_OBJECT_FIELD_LABELS')
    @payload = { :fields => @sf_fields, :field_labels => @sf_lables, :projects => [] }
    @app = Application.find(params[:id])
    @app_detail = @client.query("select #{Rails.cache.read('SALESFORCE_APP_OBJECT_FIELDS').join(", ")} from PIF_Application__c where PIF_Contact__c = '#{@app.remote_key}'").first
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
      redirect_to_back#, :alert => "Unable to mark as junk."
    end
  end
end
