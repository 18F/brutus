class Application < ActiveRecord::Base
	include PublicActivity::Model
  tracked
  
  has_many :reviews, :dependent => :destroy
  has_many :projects
	validates_uniqueness_of :remote_key, :scope => :remote_source
	acts_as_taggable_on :tags, :projects

	before_save :generate_tags

	BUCKETS = {
		:designer => [],
		:developer => [],
		:product => [],
		:business => []
	}
	
	def flagged?
		rtn = false
		self.reviews.each do |rev|
			rtn = rev.follow_up?
		end
		rtn
	end

	def details
		"<div class='loading'></div><input class='fetch-app' data-appid='#{self.id}' type='hidden' />".html_safe
	end

	# skills >> tags taxonomy
	def generate_tags

	end

	def self.tagged_like_user(user_id)
		
		# User.tagged_with(["awesome", "cool"], :any => true)
		# Application.where(:)
	end

	def self.recent(num=10)
		Application.where(:junk => false).limit(num).order(:created_at => :desc)
	end

	def self.flagged(num=10)
		Application.where(:flagged => true, :junk => false).limit(num)
	end
end