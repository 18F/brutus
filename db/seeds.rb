# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end


# fetches list of agencies from usa.gov API 
puts 'AGENCIES'
agency_url = 'http://www.usa.gov/api/USAGovAPI/contacts.json/contacts?sort=name&query_filter=language::en'
puts "fetching agency list from: #{agency_url}"
agency_tree = HTTParty.get(URI.encode(agency_url), headers: {'Content-Type' => 'application/json'})
agencies = agency_tree['Contact']
agencies.each do |agency| 
	if a = Agency.find_or_create_by_name(:name => agency['Name'])
		begin
			domain = URI.parse(agency['Web_Url'].first['Url']).host.gsub('www.','').gsub('www1.','').gsub('www2.','')
			a.email_suffix = domain
		rescue
			puts "-- No email suffix found for: #{a.name}"
		end
		a.save
		puts a.name
	end
end
