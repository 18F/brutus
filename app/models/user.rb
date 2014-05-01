class User < ActiveRecord::Base
  include PublicActivity::Model
  rolify

  has_many :reviews
  belongs_to :agency

  after_create :add_roles
  after_create :notify_admin

  validates_presence_of :name
  validates_uniqueness_of :email
  validates_uniqueness_of :uid

  acts_as_taggable

  # devise :omniauthable, :trackable

  def has_gov_email?
    return %w{ .gov .mil .fed.us }.any? {|x| self.email.end_with?(x)}
  end

  def add_roles
    add_role :admin if User.count == 1 # make the first user an admin
    add_role :user
  end

  def notify_admin
    Resque.enqueue(NotifyAdminJob, "User created: #{self.name}")
  end

  def like_apps
    Application.tagged_with(self.tag_list, :any => true)
  end

  def fancy_tag_list
    str = ""
    self.tag_list.each do |tag|
      str = str + "<span class='tag'>#{tag}</span>"
    end
    return str.html_safe
  end

  def log_sign_in(ip,auth)
    self.sign_in_count = self.sign_in_count+1
    self.last_sign_in_at, self.current_sign_in_at = Time.now, Time.now
    self.current_sign_in_ip, self.last_sign_in_ip = ip, ip
    self.token = auth['credentials']['token']
    if auth['info']
      self.name = auth['info']['name'] if auth['info']['name']
      self.email = auth['info']['email'] if auth['info']['email']
    end
    if self.agency.nil? and agency = Agency.find_by_email_suffix(self.email.split("@").last)
      self.agency_id = agency.id
    end
    self.create_activity(:sign_in)
    self.save
  end

  def log_sign_out(ip)
    self.current_sign_in_ip, self.current_sign_in_at = nil, nil
    self.create_activity(:sign_out)
    self.save
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.token = auth['credentials']['token']
      if auth['info']
        user.name = auth['info']['name'] || auth['info']['email']
        user.email = auth['info']['email'] || ""
      end
      if agency = Agency.find_by_email_suffix(user.email.split("@").last)
        user.agency = agency
      end
    end
  end
end

