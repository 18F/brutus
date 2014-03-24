class Review < ActiveRecord::Base
	include PublicActivity::Model
  tracked
  before_save :flag_review

	belongs_to :user
	belongs_to :application

	def flag_review
		if self.follow_up?
			self.application.flagged = true
		else
			self.application.flagged = false
		end
		self.application.save
	end

	def self.recent(num=10)
		Review.limit(num).order(:created_at => :desc)
	end
end
