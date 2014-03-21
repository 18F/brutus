# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :application do
    remote_key "MyString"
    remote_source "MyString"
    status "MyString"
    name "MyString"
  end
end
