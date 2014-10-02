require "redis"

if Rails.env == 'production' or Rails.env == 'qa' or Rails.env == 'staging'
	# $REDIS = Redis::Namespace.new("brutus", :redis => Redis.new(:path => ENV['REDIS_SOCK']))
	if ENV['REDIS_SOCK']
		$REDIS = Redis.new(:path => ENV['REDIS_SOCK'])
		puts "Connecting to redis at #{ENV['REDIS_SOCK']}"
	elsif ENV['REDIS_HOST']
		$REDIS = Redis.new(:host => ENV['REDIS_HOST'], :port => ENV['REDIS_PORT'])
	end
else
	redis_conf = File.read(Rails.root.join("config/redis", "#{Rails.env}.conf"))
	conf_file = Rails.root.join("config/redis", "#{Rails.env}.conf").to_s
	port = /port.(\d+)/.match(redis_conf)[1]
	# `redis-server #{conf_file}`
	# res = `ps aux | grep redis-server`

	# unless res.include?("redis-server") && res.include?(Rails.root.join("config/redis", "#{Rails.env}.conf").to_s)
	#   raise "Couldn't start redis"
	# end

	# $REDIS = Redis::Namespace.new("brutus", :redis => Redis.new(:port => port))
	$REDIS = Redis.new(:port => port)
	Rails.logger.info "Connecting to redis on port #{port}"
end



# if defined?(PhusionPassenger)
#   PhusionPassenger.on_event(:starting_worker_process) do |forked|
#     if forked
#       $REDIS.client.disconnect
#       # $REDIS = Redis::Namespace.new("brutus", :redis => Redis.new(:port => port))
#       Rails.logger.info "Reconnecting to redis"
#     else
#       # We're in conservative spawning mode. We don't need to do anything.
#     end
#   end
# end


Resque.redis = $REDIS

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }
Resque.after_fork = Proc.new do
	# Resque.redis = $REDIS
	# ActiveRecord::Base.establish_connection
  # Resque.redis.client.reconnect
end