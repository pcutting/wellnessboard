set :ip_address, "68.233.8.61"
set :user, "railsapps"
#set :scm_user, "railsapps"
set :password, "sprint1"
set :server, "freemyrealestate.com"
set :application, "wellnessboard"
set :repository,  "git@github.com:pcutting/wellnessboard.git"
set :scm, "git"

set :use_sudo, false
set :group_writable, false
#set :password, "sprint1"
#set :use_sudo , true

set :rails_env, 'production'

## set :runner , user
# set :scm_command, "/home/deploy/bin/git" 


set :branch, "master"

set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
#set :ssh_options, { :forward_agent => true }


set :deploy_to, "/home/#{user}/#{application}"

role :app, ip_address
role :web, ip_address
role :db,  ip_address, :primary => true

task :after_update_code, :roles => [:web, :db, :app] do
  run "chmod 755 #{release_path}/public -R"
end

namespace :deploy do
desc "restart passenger"
  run "touch #{current_path}/tmp/restart.txt"
  #end
end

