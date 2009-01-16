set :application, "oauth-sp-sandbox"
set :repository,  "git://github.com/moelee/oauth-sp-sandbox.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/root/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm, :git
set :branch, "master"

default_run_options[:pty] = true
set :ssh_options, {:forward_agent => true}
set :user, "moseslee"

role :app, "174.129.246.97"
role :web, "174.129.246.97"
role :db,  "174.129.246.97", :primary => true