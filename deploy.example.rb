# use a user where you have set up SSH key authentication, or use root if you have to
set :user, 'root'

# Use this if running as root, I did not use it when logging in with capistrano as a non-root user
#set :run_method, :run

# Be sure to fill in your server host name or IP.
role :app, 'your-host-name-or-ip'

default_run_options[:pty] = true