class NotifyAdminJob

  @queue = :default

  require 'twilio-ruby'

  ACCOUNT_SID = ENV['TWILIO_SID']
  AUTH_TOKEN = ENV['TWILIO_TOKEN']

  @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN

  def self.perform(message)
    @client.account.messages.create(
      :from => '+13015794120',
      :to => '+15105164120',
      :body => "[#{Rails.env}] #{message}"
    )
  end
end