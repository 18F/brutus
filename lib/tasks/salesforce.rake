namespace :salesforce do
	task :sync => :environment do
		new_import = Import.create
    Resque.enqueue(SalesforceSyncJob, new_import.id)
	end
end