# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails/tree/master/assets
#   https://github.com/capistrano/rails/tree/master/migrations
#
# require 'capistrano/rvm'
require 'capistrano/rbenv'
# require 'capistrano/chruby'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
# require 'capistrano/maintenance'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }

Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }


# require "capistrano-resque" # keep last line

namespace :resque do

  desc "Restart resque workers"
  task :restart_workers do
    invoke 'resque:stop_workers'
    invoke 'resque:start_workers'
end

  desc "Starts resque workers"
  task :start_workers do
    on roles(:resque_worker), in: :parallel do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :resque, 'work -d -p=tmp/pids/resque_worker_1.pid > ./log/resque.log'
        end
      end
    end
  end

  desc "Stop Resque Workers"
  task :stop_workers do
    on roles(:app) do
      begin
        execute "if [ -e #{current_path}/tmp/pids/resque_worker_1.pid ]
          then for f in `ls #{current_path}/tmp/pids/resque_worker*.pid`
          do kill -s QUIT `cat $f` && rm $f; done; fi"
      rescue
        # do nothing
      end
    end
  end
end