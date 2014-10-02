# require 'new_relic/recipes'

set :application, 'brutus'
set :repo_url, 'git@github.com:18F/brutus.git'
set :scm, :git

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :default_stage, :qa
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, '/var/www/brutus'
set :current_path, "#{deploy_to}/current"
set :shared_path, "#{deploy_to}/shared"
set :use_sudo, :false
set :format, :pretty
set :log_level, :debug

set :pty, true
set :ssh_options, { :forward_agent => true }
set :resque_environment_task, true

set :linked_files, %w{config/database.yml config/application.yml config/newrelic.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system}

set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end


  # before :starting, 'maintenance:enable'
  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:migrate'
  after :finishing, 'resque:restart_workers'
  after :finishing, 'deploy:restart'
  # after :finished, 'maintenance:disable'
  # after :finished, 'newrelic:notice_deployment' [TODO]
end
