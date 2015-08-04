#!/usr/bin/env puma

# start puma with:
# RAILS_ENV=beta bundle exec puma -C ./config/puma-beta.rb

application_path = '/home/w3villa/bingo/current'
railsenv = 'beta'
directory application_path
environment railsenv
daemonize true
pidfile "#{application_path}/tmp/pids/puma-#{railsenv}.pid"
state_path "#{application_path}/tmp/pids/puma-#{railsenv}.state"
stdout_redirect "#{application_path}/log/puma-#{railsenv}.stdout.log", "#{application_path}/log/puma-#{railsenv}.stderr.log"
threads 0, 16
bind "unix:///tmp/bingo.sock"