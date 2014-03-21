class SalesforceSyncJob
  @queue = :default

  def self.perform
    @client = Restforce.new(:host => ENV['SALESFORCE_HOST'])
    @desc = @client.describe(ENV['SALESFORCE_APP_OBJECT'])
    @apps = @client.query("select Id from #{ENV['SALESFORCE_APP_OBJECT']}")
    @fields_arr = @desc.fields.map { |f| f.name }

    # client.query('select Id, (select Name from Children__r) from Account').Children__r.first.Name

    @apps.each do |app|
      puts Application.find_or_create_by_remote_key(:remote_key => app['Id'], :status => 'new', :remote_source => ENV['SALESFORCE_HOST'])
    end
  end
end