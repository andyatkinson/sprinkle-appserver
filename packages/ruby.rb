package :ruby_build, :provides => :ruby do
  description 'Install ruby and bundler'
  
  requires :install_ruby, :install_rubygems, :bundler
end

package :install_ruby do
  description 'Ruby Virtual Machine'
  version '1.8.7'
  apt %q(ruby1.8-dev ruby1.8 ri1.8 rdoc1.8 irb1.8 libreadline-ruby1.8 libruby1.8 libopenssl-ruby) do
    post :install, [%q(ln -s /usr/bin/ruby1.8 /usr/bin/ruby),
    %q(ln -s /usr/bin/ri1.8 /usr/bin/ri),
    %q(ln -s /usr/bin/rdoc1.8 /usr/bin/rdoc),
    %q(ln -s /usr/bin/irb1.8 /usr/bin/irb)]
  end
  
  verify 'binaries' do
    has_file '/usr/bin/ruby1.8'
    has_file '/usr/bin/ri1.8'
    has_file '/usr/bin/rdoc1.8'
    has_file '/usr/bin/irb1.8'
  end
end

package :install_rubygems do
  description 'Rubygems'
  version '1.3.7'
  source "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz" do
    custom_install 'ruby setup.rb'
  end
  requires :install_ruby
  
  verify 'binaries' do
    has_file '/usr/bin/gem'
  end
end

package :config_gemrc do
  gemrc_template =`cat #{File.join(File.dirname(__FILE__), '..', 'assets', 'gemrc')}`
  gemrc_file = "/home/#{DEPLOY_USER}/.gemrc"

  push_text gemrc_template, gemrc_file
  runner "chown #{DEPLOY_USER}:#{DEPLOY_USER} #{gemrc_file}"

  verify do
    has_file gemrc_file
  end
end

package :bundler do
  # only need to symlink bundler because all other gems should be in Gemfile and can be run using bundle exec (or binstubs)
  runner "gem install bundler --version=1.0.22"
  runner "ln -s /usr/lib/ruby/gems/1.8/gems/bundler-1.0.22/bin/bundle /usr/local/bin/bundle"
  runner "export RUBYOPT=rubygems"
  
  verify do 
    @commands << 'gem list | grep bundler'
    has_symlink '/usr/local/bin/bundle', '/usr/lib/ruby/gems/1.8/gems/bundler-1.0.22/bin/bundle'
  end
end