# Settings for production server
set :user, 'application'
server 'rails01.bingoapi.com', :app
set :rvm_type, :system
set :use_sudo, false
set :deploy_via, :remote_cache
set :copy_exclude, [ '.git' ]
set :rvm_ruby_version, 'ruby-2.2.2'
set :port, 22 

set :deploy_to, "/apps/#{application}"
