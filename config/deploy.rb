#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require 'bundler/capistrano'
#require 'capistrano/deepmodules'

set :application, "gaidarfund"
set :deploy_to, "/srv/www/apps/gaidarfund"
set :deploy_via, :remote_cache
set :use_sudo, true
set :user, "www"
set :unicorn_conf, '/srv/www/apps/gaidarfund/current/config/unicorn.rb'

set :rvm_ruby_string, "1.9.2"
set :rvm_type, :user

set :scm, "git"
set :repository,  "git@ram.unfuddle.com:ram/gaidarfundproject.git"
set :branch, "master"

role :web, "beta.gaidarfund.ru"                          # Your HTTP server, Apache/etc
role :app, "beta.gaidarfund.ru"                          # This may be the same as your `Web` server
role :db,  "beta.gaidarfund.ru", :primary => true # This is where Rails migrations will run

default_run_options[:pty] = true

after "bundle:install", "deploy:auto_migrate"

namespace :deploy do
  task :start do
    run "bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
   end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :auto_migrate do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} db:auto:migrate"
  end
  task :load_db do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} db:load"
  end
end