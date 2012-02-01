require 'packages/build_essential'
require 'packages/iptables'
require 'packages/scm'
require 'packages/memcached'
require 'packages/nginx'
require 'packages/ruby'
require 'packages/database'
require 'packages/redis'

policy :appserver, :roles => :app do
  requires :build_essential
  requires :iptables
  requires :scm  
  requires :memcached
  requires :webserver
  requires :database
  requires :redis
  requires :ruby
end

deployment do
  delivery :capistrano

  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end