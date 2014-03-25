class SalesforceSyncJob
  @queue = :default

  def self.perform(import_id)
    @client = Restforce.new(:host => ENV['SALESFORCE_HOST'])
    @apps = @client.query("select Id from #{ENV['SALESFORCE_APP_OBJECT']}")
    @fields_arr = Rails.cache.read('SALESFORCE_FIELDS_ARRAY')

    new_apps = []
    @apps.each do |sf_app|
      unless app = Application.where(:remote_key => sf_app['Id']).first
        new_app = Application.create(:remote_key => sf_app['Id'], :status => 'new', :remote_source => ENV['SALESFORCE_HOST'], :name => sf_app['Id'])
        sf_fields = Rails.cache.read('SALESFORCE_FIELDS_ARRAY')
        detail = @client.select(ENV['SALESFORCE_APP_OBJECT'], new_app.remote_key, sf_fields)
        begin
          new_app.vet_status = detail['Veteran_Status__c']
          new_app.tag_list = detail['Skills__c'].split(';').join(', ')
        rescue
          # do nothing
        end
        new_apps << new_app
        new_app.save
      end
    end

    import = Import.find(import_id)
    import.imports = new_apps.size
    import.remote_source = ENV['SALESFORCE_HOST']
    import.save
  end
end