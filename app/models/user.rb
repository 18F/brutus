class User < ActiveRecord::Base

  rolify

  has_many :reviews

  after_create :add_roles

  validates_presence_of :name
  validates_uniqueness_of :email
  validates_uniqueness_of :uid

  acts_as_taggable

  def has_gov_email?
    return %w{ .gov .mil .fed.us }.any? {|x| self.email.end_with?(x)}
  end

  def add_roles
    self.add_role :admin if User.count == 1 # make the first user an admin
    self.add_role :agency_admin if self.has_gov_email?
  end

  def log_sign_in(ip)
    self.sign_in_count = self.sign_in_count+1
    self.last_sign_in_at = Time.zone.now
    self.current_sign_in_at = Time.zone.now
    self.current_sign_in_ip = ip
    self.last_sign_in_ip = ip
    self.save
  end

  def log_sign_out(ip)
    self.current_sign_in_ip = nil
    self.current_sign_in_at = nil
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

