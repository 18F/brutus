class CreditingPlan < ActiveRecord::Base
	has_many :crediting_plan_categories
end
