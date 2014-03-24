class SalesforceQueryApplicationJob
  @queue = :default

  def self.perform(app_id)
    client = SF_CLIENT
    sf_fields = Rails.cache.read('SALESFORCE_FIELDS_ARRAY')
    app = Application.find(app_id)
    detail = client.select(ENV['SALESFORCE_APP_OBJECT'], app.remote_key, sf_fields)
    Rails.cache.write("SALESFORCE_APP_#{app.id}", detail.to_json)
    app.name = detail["Name"]
    app.status = 'cached'
    app.save
  end
end