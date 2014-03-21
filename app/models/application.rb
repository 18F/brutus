class Application < ActiveRecord::Base
	include PublicActivity::Model
  tracked
  
  has_many :reviews
	validates_uniqueness_of :remote_key, :scope => :remote_source

	def flagged?
		self.reviews.each do |rev|
			return true if rev.follow_up?
		end
		false
	end

	def self.recent(num=10)
		Application.limit(num).order(:created_at => :desc)
	end

	def self.flagged(num=10)
		# Review.where(:follow_up => true)
		Application.joins(:reviews).where('reviews.follow_up IS ?',true)
	end
end
