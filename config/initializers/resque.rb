# # Resque tasks
# require 'resque/tasks'
# require 'resque/scheduler/tasks'

# namespace :resque do
#   task :setup do
#     require 'resque'
#     require 'resque-scheduler'

#     # you probably already have this somewhere
#     Resque.redis = 'localhost:6379'

#     # If you want to be able to dynamically change the schedule,
#     # uncomment this line.  A dynamic schedule can be updated via the
#     # Resque::Scheduler.set_schedule (and remove_schedule) methods.
#     # When dynamic is set to true, the scheduler process looks for
#     # schedule changes and applies them on the fly.
#     # Note: This feature is only available in >=2.0.0.
#     # Resque::Scheduler.dynamic = true

#     # The schedule doesn't need to be stored in a YAML, it just needs to
#     # be a hash.  YAML is usually the easiest.
#     # Resque.schedule = YAML.load_file('your_resque_schedule.yml')

#     # If your schedule already has +queue+ set for each job, you don't
#     # need to require your jobs.  This can be an advantage since it's
#     # less code that resque-scheduler needs to know about. But in a small
#     # project, it's usually easier to just include you job classes here.
#     # So, something like this:
#     require 'jobs'
#   end
# end

# Resque.redis = 'localhost:6379'
# Resque.redis = $redis

# Resque.after_fork do
# 	Resque.redis.client.reconnect
# end

# Resque.after_fork do |job|
#   ActiveRecord::Base.establish_connection
# end

# Resque.configure do |config|

#   # Set the redis connection. Takes any of:
#   #   String - a redis url string (e.g., 'redis://host:port')
#   #   String - 'hostname:port[:db][/namespace]'
#   #   Redis - a redis connection that will be namespaced :resque
#   #   Redis::Namespace - a namespaced redis connection that will be used as-is
#   #   Redis::Distributed - a distributed redis connection that will be used as-is
#   #   Hash - a redis connection hash (e.g. {:host => 'localhost', :port => 6379, :db => 0})
#   config.redis = 'localhost:6379'

# end






# require "redis"

# if Rails.env == 'production' or Rails.env == 'qa' or Rails.env == 'staging'
# 	$redis = Redis::Namespace.new("brutus", :redis => Redis.new(:path => ENV['REDIS_SOCK']))
# else
# 	redis_conf = File.read(Rails.root.join("config/redis", "#{Rails.env}.conf"))
# 	conf_file = Rails.root.join("config/redis", "#{Rails.env}.conf").to_s
# 	port = /port.(\d+)/.match(redis_conf)[1]
# 	`redis-server #{conf_file}`
# 	res = `ps aux | grep redis-server`

# 	unless res.include?("redis-server") && res.include?(Rails.root.join("config/redis", "#{Rails.env}.conf").to_s)
# 	  raise "Couldn't start redis"
# 	end

# 	$redis = Redis::Namespace.new("brutus", :redis => Redis.new(:port => port))
# end

# Resque.redis = $redis

# Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }
# Resque.after_fork = Proc.new do
# 	# Resque.redis = $redis
# 	# ActiveRecord::Base.establish_connection
#   Resque.redis.client.reconnect
# end

# Resque.redis = Redis.new
# Resque.redis = $REDIS
# Resque.logger = Logger.new("#{Rails.root}/log/resque.log")