require 'config'
require 'packages/build_essential'
require 'packages/ssh'
require 'packages/iptables'
require 'packages/scm'
require 'packages/memcached'
require 'packages/nginx'
require 'packages/ruby'
require 'packages/database'
require 'packages/redis'
require 'packages/deploy'

policy :appserver, :roles => :app do
  requires :build_essential
  #requires :ssh
  requires :iptables
  requires :scm  
  requires :memcached
  requires :webserver
  requires :database
  requires :redis
  requires :ruby
  requires :deploy
end

deployment do
  delivery :capistrano do
    recipes 'deploy'
  end

  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end