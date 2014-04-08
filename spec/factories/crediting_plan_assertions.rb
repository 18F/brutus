# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :crediting_plan_assertion do
    score 1
    description "MyText"
    crediting_plan_category nil
  end
end
