#load 'deploy' if respond_to?(:namespace) # cap2 differentiator
#Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
#load 'config/deploy'


load 'deploy' if respond_to?(:namespace) # cap2 differentiator
load 'config/deploy'

namespace :deploy do

task :restart, :roles => :app do
run "chmod 755 #{release_path}/public -R"
run "touch #{deploy_to}/current/tmp/restart.txt"
end

end

