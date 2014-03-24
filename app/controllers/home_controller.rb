class HomeController < ApplicationController

  before_filter :authenticate_user!, :only => [:sync, :app_details]

  def index
    redirect_to admin_root_path if user_signed_in?
    @activities = PublicActivity::Activity.all.limit(10)
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
    Resque.enqueue(SalesforceSyncJob)
    render :json => 'success'
  end

  def app_details
    @client ||= SF_CLIENT
    @sf_fields ||= Rails.cache.read('SALESFORCE_FIELDS_ARRAY')
    @app = Application.find(params[:id])
    @detail = @client.select(ENV['SALESFORCE_APP_OBJECT'], @app.remote_key, @sf_fields)
    render :json => { :application => @detail, :fields => JSON.parse(Rails.cache.read('SALESFORCE_FIELDS_DETAIL')) }
  end
end
