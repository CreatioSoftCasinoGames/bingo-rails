# Settings for production server
set :user, 'w3villa'
server 'bingo-rails-1.bingoapi.com', :app, :web, :db, :primary => true
server 'bingo-rails-2.bingoapi.com', :app, :web
set :rvm_type, :user
set :use_sudo, false
set :deploy_via, :remote_cache
set :rvm_ruby_version, 'ruby-2.1.0'
set :port, 22 

set :deploy_to, "/home/#{user}/#{application}"
