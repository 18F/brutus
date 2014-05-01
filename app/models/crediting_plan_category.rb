class CreditingPlanCategory < ActiveRecord::Base
  belongs_to :crediting_plan
  has_many :crediting_plan_assertions, :dependent => :destroy
end
