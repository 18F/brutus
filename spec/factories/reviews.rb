# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    comments "MyText"
    score false
    type ""
  end
end