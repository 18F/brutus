# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :crediting_plan_category do
    name "MyString"
    description "MyText"
    crediting_plan nil
  end
end
