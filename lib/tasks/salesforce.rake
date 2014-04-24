namespace :salesforce do
	task :enqueue_sync => :environment do
		new_import = Import.create
    Resque.enqueue(SalesforceSyncJob, new_import.id)
	end

	task :sync => :environment do
		puts "*** SYNCING WITH SALESFORCE ***"
		puts "     this may take a while..."
		SalesforceSyncJob.perform
		puts "*** DONE ***"
	end

end

task :clear_cache => :environment do
	Rails.cache.clear
end