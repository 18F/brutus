require "redis"

if Rails.env == 'production' or Rails.env == 'qa' or Rails.env == 'staging'
	$redis = Redis::Namespace.new("brutus", :redis => Redis.new(:path => ENV['REDIS_SOCK']))
else
	redis_conf = File.read(Rails.root.join("config/redis", "#{Rails.env}.conf"))
	conf_file = Rails.root.join("config/redis", "#{Rails.env}.conf").to_s
	port = /port.(\d+)/.match(redis_conf)[1]
	`redis-server #{conf_file}`
	res = `ps aux | grep redis-server`

	unless res.include?("redis-server") && res.include?(Rails.root.join("config/redis", "#{Rails.env}.conf").to_s)
	  raise "Couldn't start redis"
	end

	$redis = Redis::Namespace.new("brutus", :redis => Redis.new(:port => port))
end



