# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :second_factor do
    encrypted_password "MyString"
    active false
  end
end
