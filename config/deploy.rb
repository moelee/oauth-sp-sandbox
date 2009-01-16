set :application, "oauth-sp-sandbox"
set :repository,  "git://github.com/moelee/oauth-sp-sandbox.git"
set :branch, "master"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/root/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm, :git
set :user, 'root'
ssh_options[:port] = 22
ssh_options[:username] = 'root'
ssh_options[:host_key] = 'ssh-dss'
ssh_options[:keys] = '~/.ssh/id_rsa'
ssh_options[:paranoid] = false

set :use_sudo, false

#default_run_options[:pty] = true
#set :ssh_options, {:forward_agent => true}

role :app, "174.129.246.97"
role :web, "174.129.246.97"
role :db,  "174.129.246.97", :primary => true