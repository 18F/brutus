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
    rescue
      render :json => "I'm not sure what is going on.", :status => 200
    end
  end

  def app_details
    @client ||= SF_CLIENT
    @sf_fields ||= Rails.cache.read('SALESFORCE_APP_OBJECT_FIELDS')
    @app = Application.find(params[:id])
    # @detail = @client.select(ENV['SALESFORCE_APP_OBJECT'], @app.remote_key, @sf_fields)
    @detail = @client.query("select #{Rails.cache.read('SALESFORCE_APP_OBJECT_FIELDS').join(", ")} from PIF_Application__c where PIF_Contact__c = '#{@app.remote_key}'").first
    render :json => { :application => @detail, :fields => Rails.cache.read('SALESFORCE_APP_OBJECT_FIELDS') }
  end
end
