class SalesforceJob
  @queue = :salesforce

  def self.perform
    # Resque.enqueue(SendAlertJob, alert_id, user.id)
    @client = Restforce.new(:host => ENV['SALESFORCE_HOST'])

    @desc = @client.describe(ENV['SALESFORCE_APP_OBJECT'])
    # @client.without_caching do
    #   @apps = @client.query("select Id from #{ENV['SALESFORCE_APP_OBJECT']}")
    # end
    @apps = @client.query("select Id from #{ENV['SALESFORCE_APP_OBJECT']}")
    @fields_arr = @desc.fields.map{|f| f.name}
  end
end