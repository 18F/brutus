require 'json'
require_relative '../utils/random_data'

namespace :admin do
  desc "TODO"
  task fake: :environment do
    if ENV['NUM_RECORDS'].nil?
      print "How many fake applications do you want? "
      num_records = $stdin.gets.to_i
    else
      num_records = ENV['NUM_RECORDS'].to_i
    end
    data = nil
    File.open(File.join(File.dirname(__FILE__),"sample_data","app_data.json"), "r") do |f|
      str = f.read
      data = JSON.parse(str)
    end


    num_records.times do
      puts "*"*80
      name = Faker::Name.name
      email = Faker::Internet.email(name)
      data["Applicant_Name__c"] = name
      data["Email_Address__c"] = email
      data["Email__c"] = email
      data["Phone_Number__c"] = Faker::PhoneNumber.phone_number
      data["Current_Employer__c"] = Faker::Company.name
      data["projects"] = RandomData::project_reasons
      data["Link_1__c"] = Faker::Internet.url
      data["Link_2__c"] = Faker::Internet.url
      data["Link_3__c"] = Faker::Internet.url
      data["Motivation__c"] = Faker::Company.bs.capitalize!
      puts data.inspect
    end
    print "#{num_records} created.n"

  end

end
