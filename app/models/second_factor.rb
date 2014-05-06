class SecondFactor < ActiveRecord::Base

	def self.active?
		SecondFactor.where(:active => true).any?
	end

	def self.active
		SecondFactor.where(:active => true).first
	end

	def self.validate_password(hsh)
    begin
      if hsh[:password] == hsh[:password_confirmation]
        password = hsh[:password]
      end
      password if password.length >= 8
    rescue
      nil
    end
  end
end
