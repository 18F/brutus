class Review < ActiveRecord::Base
	include PublicActivity::Model
  tracked
  
	belongs_to :user
	belongs_to :application
	
	def self.recent(num=10)
		Review.limit(num).order(:created_at => :desc)
	end
end
