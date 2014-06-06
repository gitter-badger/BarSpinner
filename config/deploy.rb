require "rvm/capistrano"
require "bundler/capistrano"

server "162.243.28.237", :web, :app, :db, primary: true

set :application, "barspinner"
set :user, "deployer"
set :password, "deployer.11"
set :port, 22
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :scm, "git"
set :repository, "git@github.com:azaytc/BarSpinner.git"
set :branch, "master"

#set rvm variables and configuration
set :rvm_ruby_string, "ruby-1.9.3-p429"
set :rvm_type, :system
set :rvm_path, '/usr/local/rvm'


default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
before "deploy:assets:precompile", "deploy:link_db"
after "deploy:setup", "deploy:setup_shared"
after 'deploy', 'deploy:restart'

namespace :deploy do
  desc "Tell Passenger to restart."
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink extra configs and folders."
  task :link_db do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Setup shared directory."
  task :setup_shared do
    run "mkdir #{shared_path}/config"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run "cd #{current_path} && #{rake} RAILS_ENV=#{rails_env} RAILS_GROUPS=assets assets:precompile --trace"
    end
  end

end