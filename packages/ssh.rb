package :configure_ssh, :provides => :ssh do
  description "Configure SSH"
  
  requires :ssh_keys, :ssh_config, :sshd_config, :ssh_restart
end

package :ssh_keys do
  description "Generate default SSH key"
  
  noop do
    pre :install, %{ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa} # TODO: -C "#{deployer}@#{domain}"
    post :install, '/etc/init.d/ssh reload'
  end

  verify do
    has_file '/root/.ssh/id_rsa'
    has_file '/root/.ssh/id_rsa.pub'
  end
end

package :ssh_config do
  description "Default SSH config"
  
  config_file = '/etc/ssh/ssh_config'
  config_template = File.join(File.dirname(__FILE__), '..', 'assets', 'ssh_config')
  
  transfer config_template, config_file do
    post :install, "/etc/init.d/ssh reload"
  end
  
  verify do
    file_contains config_file, `head -n 1 #{config_template}`
  end
end

package :sshd_config do
  description "Default SSHD config"
  
  config_file = '/etc/ssh/sshd_config'
  config_template = File.join(File.dirname(__FILE__), '..', 'assets', 'sshd_config')
  
  transfer config_template, config_file do
    post :install, "/etc/init.d/ssh reload"
  end
  
  verify do
    file_contains config_file, `head -n 1 #{config_template}`
  end
end

%w[start stop restart reload].each do |command|
  package :"ssh_#{command}" do
    runner "/etc/init.d/ssh #{command}"
  end
end

# package :ssh_custom_port do
#   replace_text 'Port 22', 'Port 2500', '/etc/ssh/sshd_config', :=> true
# end
