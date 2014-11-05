# Settings for production server
set :user, 'w3villa'
server 'bingoapi.com', :app, :web, :db, :primary => true
set :rvm_type, :user
set :use_sudo, false
set :deploy_via, :remote_cache
set :rvm_ruby_version, 'ruby-2.1.0'
set :port, 22 

set :deploy_to, "/home/#{user}/#{application}"
