client = Restforce.new(:host => ENV['SALESFORCE_HOST'])
desc = client.describe(ENV['SALESFORCE_APP_OBJECT'])
fields_arr = desc.fields.map { |f| f.name }

Rails.cache.write('SALESFORCE_FIELDS_DETAIL', desc['fields'].to_json)
Rails.cache.write('SALESFORCE_FIELDS_ARRAY', fields_arr)
SF_CLIENT = client