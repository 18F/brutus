client = Restforce.new(:host => ENV['SALESFORCE_HOST'])
desc = client.describe(ENV['SALESFORCE_APP_OBJECT'])
apps = client.query("select Id from #{ENV['SALESFORCE_APP_OBJECT']}")
fields_arr = desc.fields.map { |f| f.name }

Rails.cache.write('SALESFORCE_FIELDS',fields_arr)
SF_CLIENT = client