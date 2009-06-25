set :ip_address, "68.233.8.61"
set :user, "railsapps"
#set :scm_user, "railsapps"
set :password, "sprint1"
set :server, "freemyrealestate.com"
set :application, "wellnessboard"
set :repository, "git@github.com:pcutting/wellnessboard.git"
set :scm, "git"

set :deploy_via, :copy

set :use_sudo, false
set :group_writable, false
#set :password, "sprint1"
#set :use_sudo , true

set :rails_env, 'production'

## set :runner , user
# set :scm_command, "/home/deploy/bin/git"

set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :copy

#phils update
#set :ssh_options, { :forward_agent => true }

#phils update
#set :deploy_via, :remote_cache
#set :git_shallow_clone,1

set :deploy_to, "/home/#{user}/#{application}"

role :app, ip_address
role :web, ip_address
role :db, ip_address, :primary => true


