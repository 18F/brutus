class SalesforceSyncJob
  @queue = :default

  def self.perform(import_id=nil)
    import_id ||= Import.last.id
    @client = SF_CLIENT || Restforce.new(:host => ENV['SALESFORCE_HOST'])
    @contacts = @client.query("select Id from #{ENV['SALESFORCE_CONTACT_OBJECT']}")

    new_apps = []
    @contacts.each do |contact|
      unless app = Application.where(:remote_key => contact['Id']).first
        new_app = Application.create(:remote_key => contact['Id'], :status => 'new', :remote_source => ENV['SALESFORCE_HOST'], :name => contact['Id'])
        detail = @client.query("select #{Rails.cache.read('SALESFORCE_APP_OBJECT_FIELDS').join(", ")} from PIF_Application__c where PIF_Contact__c = '#{contact['Id']}'").first
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