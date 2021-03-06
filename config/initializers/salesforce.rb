begin
  client = Restforce.new(:host => ENV['SALESFORCE_HOST'])

  objects = [
      { "SALESFORCE_CONTACT_OBJECT" => ENV['SALESFORCE_CONTACT_OBJECT'] },
      { "SALESFORCE_APP_OBJECT" => ENV['SALESFORCE_APP_OBJECT'] }
    ]

  objects.each do |obj|
    obj.each_key do |key|
      desc = client.describe(obj[key])
      fields_arr = desc.fields.map { |f| f.name  }
      field_metadata_arr = desc.fields.map { |f| { f.name => f.label } }
      Rails.cache.write("#{key}_FIELDS", fields_arr)
      Rails.cache.write("#{key}_FIELD_METADATA", field_metadata_arr)

    end
  end


  SF_CLIENT = client
rescue Exception
  puts "!!! ERROR !!! There was an issue connecting to Salesforce!"
  puts $!, $@
end
