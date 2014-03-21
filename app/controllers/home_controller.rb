class HomeController < ApplicationController
  def index
    redirect_to admin_root_path if user_signed_in?
    @activities = PublicActivity::Activity.all
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
end
