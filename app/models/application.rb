class Application < ActiveRecord::Base
	include PublicActivity::Model
  tracked
  
  has_many :reviews, :dependent => :destroy
  has_many :projects
	validates_uniqueness_of :remote_key, :scope => :remote_source
	acts_as_taggable_on :tags, :projects, :skills

	before_save :generate_tags
	before_save :update_status

	BUCKETS = {
		:designer => [
				"Data Visualization",
				"Graphic Design",
				"User Experience (UX/UI)",
			],
		:developer => [
				"Data Analysis",
				"Web Developer (back-end)",
				"Web Developer (front-end)"
			],
		:product => [
				"Product Management",
				"Project Management"
			],
		:business => [
				"Business Development / Sales",
				"Entrepreneurship",
				"Evangelism / Public Speaking",
				"Human Resources",
				"Legal"
			]
	}

	def details
		"<div class='loading'></div><input class='fetch-app' data-appid='#{self.id}' type='hidden' />".html_safe
	end

	def fancy_tag_list
		str = ""
		self.tag_list.each do |tag|
			str = str + "<span class='tag'>#{tag}</span>"
		end
		return str.html_safe
	end

	private
	# skills >> tags taxonomy
	def generate_tags
		self.skill_list.each do |tag|
			BUCKETS.each do |bucket|
				self.tag_list.add(bucket[0].to_s.titleize) if bucket[1].include? tag
			end
		end
	end

	def update_status
		if self.reviews.any?
			self.status = 'reviewed'
		end
		if self.flagged?
			self.status = 'flagged'
		end
		if self.junk?
			self.status = 'junk'
		end
	end

	def self.recent(num=10,tag_list='')
		unless tag_list.blank?
			@apps = Application.tagged_with(tag_list, :any => true).where(:junk => false, :status => 'unreviewed').sample(num)
		else
			@apps = Application.where(:junk => false, :status => 'unreviewed').sample(num)
		end
	end

	def self.flagged(num=10,tag_list='')
		unless tag_list.blank?
			@apps = Application.tagged_with(tag_list, :any => true).where(:flagged => true, :junk => false).sample(num)
		else
			@apps = Application.where(:flagged => true, :junk => false).order("RANDOM()").sample(num)
		end
	end
end