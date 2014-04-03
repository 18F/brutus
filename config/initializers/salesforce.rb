client = Restforce.new(:host => ENV['SALESFORCE_HOST'])

objects = [
		{ "SALESFORCE_CONTACT_OBJECT" => ENV['SALESFORCE_CONTACT_OBJECT'] },
		{ "SALESFORCE_APP_OBJECT" => ENV['SALESFORCE_APP_OBJECT'] }
	]

objects.each do |obj|
	obj.each_key do |key|
		desc = client.describe(obj[key])
		fields_arr = desc.fields.map { |f| f.name }

		Rails.cache.write("#{key}_FIELDS", fields_arr)
	end
end


SF_CLIENT = client