package :nginx_source, :provides => :webserver do
  requires :build_essential, :nginx_dependencies
  description 'Nginx Web Server'
  version '1.1.7'

  source "http://nginx.org/download/nginx-#{version}.tar.gz" do
    post :install, '/etc/init.d/nginx start'
  end

  verify do
    has_executable '/etc/init.d/nginx'
    has_process 'nginx'
  end
end

package :nginx_dependencies do
  description 'Nginx Web Server Build Dependencies'
  apt %w( libc6 libpcre3 libpcre3-dev libpcrecpp0 libssl0.9.8 libssl-dev zlib1g zlib1g-dev lsb-base )
end

package :nginx_conf do
  requires :nginx
  
  conf_file = '/usr/local/nginx/conf/nginx.conf'
  conf_template = `cat #{File.join(File.dirname(__FILE__), '..', 'assets', 'nginx.example.conf')}`
  
  runner "rm #{conf_file}"
  push_text conf_template, conf_file
  runner '/etc/init.d/nginx restart'

  verify do
    file_contains conf_file, 'sites-enabled'
  end
end
