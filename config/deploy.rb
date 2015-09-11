require 'bundler/capistrano'
require 'rvm/capistrano'
require 'whenever/capistrano'
require 'capistrano/ext/multistage'

# Whenever setup for application
set(:whenever_command) { "RAILS_ENV=#{rails_env} bundle exec whenever" }
set :whenever_environment, defer { 'production' }


# Application configuration
set :application, 'bingo'
set :repository,  'git@github.com:creatiosoft/bingo-rails.git'
set :scm, :git
set :branch, 'deployment'

# Server-side system wide settings
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# Application stages configuration
set :stages, %w(production beta)
set :default_stage, 'beta'


# Deploy configuration (Unicorn, nginx)
after 'deploy', 'deploy:cleanup'

namespace :deploy do

  desc "Make sure local git is in sync with remote."
    task :check_revision, roles: :web do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
      puts "WARNING: HEAD is not the same as origin/#{branch}"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  before "deploy", "deploy:check_revision"

  namespace :figaro do
    desc "SCP transfer figaro configuration to the shared folder"
    task :setup do
      transfer :up, "config/application.yml", "#{shared_path}/application.yml", :via => :scp
    end

    desc "Symlink application.yml to the release path"
    task :symlink do
      run "ln -sf #{shared_path}/application.yml #{release_path}/config/application.yml"
    end
  end

  after  "deploy:started", "figaro:setup"
  after "deploy:symlink:release", "figaro:symlink"
  after "deploy", "deploy:migrate"

  desc "Restart the application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} ; RAILS_ENV=#{stage} bundle exec pumactl -F config/puma.rb stop ; sleep 5 ; RAILS_ENV=#{stage} bundle exec pumactl -F config/puma.rb start"
  end

end
