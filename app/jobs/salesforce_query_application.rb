class SalesforceSyncJob
  @queue = :default

  def self.perform
    @client = Restforce.new(:host => ENV['SALESFORCE_HOST'])
    # @desc = @client.describe(ENV['SALESFORCE_APP_OBJECT'])
    # @apps = @client.query("select Id from #{ENV['SALESFORCE_APP_OBJECT']}")
    # @fields_arr = @desc.fields.map { |f| f.name }

    @client.query(", (select Name from Children__r) from Account").Children__r.first.Name

    client.select('Account', '001D000000INjVe', ["Id"])
    # Application.
    # @client.select(ENV['SALESFORCE_APP_OBJECT'], )
    # client.select('Account', '001D000000INjVe', ["Id"])

  end
end