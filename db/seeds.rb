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

puts 'CREDITING PLAN'
cp = CreditingPlan.find_or_create_by(:name => "Default", :active => true)
	cpc = CreditingPlanCategory.find_or_create_by(:name => "Analysis and Creative Problem Solving", :description => "Expertise determining user needs or identifying market opportunities and designing and deploying solutions", :crediting_plan_id => cp.id)
		CreditingPlanAssertion.find_or_create_by(:score => 0, :description => "Applicant’s resume and portfolio do not adequately demonstrate this competency", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 4, :description => "Applicant's resume and portfolio demonstrate basic understanding of best practices, or baseline proficiency in this competency", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 8, :description => "Applicant's resume and portfolio demonstrate above-average proficiency in this area while working primarily as an individual rather than as part of a team", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 12, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding in this area, and ability to work effectively both independently and as a team or community member", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 16, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding in this area, and shows evidence of significant contributions to a team or community environment such as leadership, promotion, or accolades", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 20, :description => "Applicant's ability to perform these tasks at a high level, as well as their team leadership, thought-leadership, writings, teachings, or appearances in these areas affirm that they are widely regarded as an expert in this subject area", :crediting_plan_category_id => cpc.id)

	cpc = CreditingPlanCategory.find_or_create_by(:name => "Technology Acumen", :description => "Ability to translate business problems into technology solutions that draw on current and emergent tools and technologies; while likewise describing esoteric and highly technical solutions to non-technical stakeholders", :crediting_plan_id => cp.id)
		CreditingPlanAssertion.find_or_create_by(:score => 0, :description => "Applicant’s resume and portfolio do not adequately demonstrate this competency", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 4, :description => "Applicant's resume and portfolio demonstrate basic understanding of best practices, or baseline proficiency in this competency", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 8, :description => "Applicant's resume and portfolio demonstrate above-average proficiency in this area while working primarily as an individual rather than as part of a team", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 12, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding in this area, and ability to work effectively both independently and as a team or community member", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 16, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding in this area, and shows evidence of significant contributions to a team or community environment such as leadership, promotion, or accolades", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 20, :description => "Applicant's ability to perform these tasks at a high level, as well as their team leadership, thought-leadership, writings, teachings, or appearances in these areas affirm that they are widely regarded as an expert in this subject area", :crediting_plan_category_id => cpc.id)

	cpc = CreditingPlanCategory.find_or_create_by(:name => "Entrepreneurship and Product Management", :description => "Experience delivering products or services from concept to market", :crediting_plan_id => cp.id)
		CreditingPlanAssertion.find_or_create_by(:score => 0, :description => "Applicant’s resume and portfolio do not adequately demonstrate this competency", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 4, :description => "Applicant's resume and portfolio demonstrate basic understanding of best practices, or baseline proficiency in this competency", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 8, :description => "Applicant's resume and portfolio demonstrate above-average proficiency in this area while working primarily as an individual rather than as part of a team", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 12, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding in this area, and ability to work effectively both independently and as a team or community member", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 16, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding in this area, and shows evidence of significant contributions to a team or community environment such as leadership, promotion, or accolades", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 20, :description => "Applicant's ability to perform these tasks at a high level, as well as their team leadership, thought-leadership, writings, teachings, or appearances in these areas affirm that they are widely regarded as an expert in this subject area", :crediting_plan_category_id => cpc.id)

	cpc = CreditingPlanCategory.find_or_create_by(:name => "Approach and Methodology", :description => "Expertise applying frameworks that emphasize delivery, iteration, quantitative and qualitative learnings, and responsiveness", :crediting_plan_id => cp.id)
		CreditingPlanAssertion.find_or_create_by(:score => 0, :description => "Applicant’s resume and portfolio do not adequately demonstrate this competency", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 4, :description => "Applicant's resume and portfolio demonstrate basic understanding of best practices, or baseline proficiency in this competency", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 8, :description => "Applicant's resume and portfolio demonstrate above-average proficiency in this area while working primarily as an individual rather than as part of a team", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 12, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding in this area, and ability to work effectively both independently and as a team or community member", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 16, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding in this area, and shows evidence of significant contributions to a team or community environment such as leadership, promotion, or accolades", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 20, :description => "Applicant's ability to perform these tasks at a high level, as well as their team leadership, thought-leadership, writings, teachings, or appearances in these areas affirm that they are widely regarded as an expert in this subject area", :crediting_plan_category_id => cpc.id)

	cpc = CreditingPlanCategory.find_or_create_by(:name => "Empathy and Emotional Intelligence", :description => "Experience in client-facing roles, navigating bureaucracy,  business development, or delivering services with a strong user-facing or consumer-oriented element", :crediting_plan_id => cp.id)
		CreditingPlanAssertion.find_or_create_by(:score => 0, :description => "Applicant’s resume and portfolio do not adequately demonstrate this competency", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 4, :description => "Applicant's resume and portfolio demonstrate basic understanding of best practices, or baseline proficiency in this competency", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 8, :description => "Applicant's resume and portfolio demonstrate above-average proficiency in this area while working primarily as an individual rather than as part of a team", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 12, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding in this area, and ability to work effectively both independently and as a team or community member", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 16, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding in this area, and shows evidence of significant contributions to a team or community environment such as leadership, promotion, or accolades", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 20, :description => "Applicant's ability to perform these tasks at a high level, as well as their team leadership, thought-leadership, writings, teachings, or appearances in these areas affirm that they are widely regarded as an expert in this subject area", :crediting_plan_category_id => cpc.id)

	cpc = CreditingPlanCategory.find_or_create_by(:name => "Tools and Execution", :description => "Experience in design, development and deployment of solutions leveraging current and emergent technologies and best practices. NOTE: “full stack” refers to individuals capable of working with both server-side and client-side technologies. Typically individuals are proficient in working with databases, system infrastructure, applications or frameworks, and web, browser.", :crediting_plan_id => cp.id)
		CreditingPlanAssertion.find_or_create_by(:score => 0, :description => "Applicant’s resume and portfolio do not adequately demonstrate ability to perform these tasks", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 4, :description => "Applicant's resume and portfolio demonstrate basic understanding of best practices, or baseline proficiency in current and emergent technologies", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 8, :description => "Applicant's resume and portfolio demonstrate above-average proficiency in this competency while working primarily as an individual rather than as part of a team", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 12, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding across a “full-stack” of current and emergent technologies and ability to work both independently and as a team member, including contributions to open-source", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 16, :description => "Applicant's resume and portfolio demonstrate mastery and deep understanding across a “full-stack” of current and emergent technologies, and displays leadership either as a manager, formal team lead, or open source project lead", :crediting_plan_category_id => cpc.id)
		CreditingPlanAssertion.find_or_create_by(:score => 20, :description => "Applicant's ability to perform these tasks at a high level, as well as their team leadership, thought-leadership, writings, teachings, or appearances in these areas affirm that they are widely regarded as an expert in this subject area", :crediting_plan_category_id => cpc.id)

