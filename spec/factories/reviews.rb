# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    user_id 1
    score 1
    remarks "MyText"
    follow_up false
  end
end
