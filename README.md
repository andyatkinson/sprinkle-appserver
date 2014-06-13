## Sprinkle

Use the Sprinkle tool to automate the setup of an application server on Linux.

### How does this work?

Sprinkle uses "packages" which are things to install. They can be installed from source or from a package manager. Package installation scripts are in the "packages" directory and if they require a static or generated configuration file, those can be found in the "assets" directory.

### What does it install?

 - apt package manager
 - iptables
 - memcached
 - nginx
 - redis
 - ruby
 - mysql
 - git
 - (broken) copy ssh config and sshd config files
 - (broken) add deploy user
 
### Test the configuration

    sprinkle -s install.rb -t

### Installation

  setup: the memcache package right now as a deploy:deploy user and group, so you will have to `adduser deploy` on the box
  or change that as necessary. `cp config.example.rb config.rb` and customize with your settings.

  1. `gem install sprinkle`
  2. `cp deploy.example.rb deploy.rb` and customize.
  3. `sprinkle -c -s install.rb`

### More information

 - `sprinkle --help`
 - [Sprinkle Documentation](http://rubydoc.info/github/crafterm/sprinkle/master)
 - Thoughtbot [Sprinkle scripts](https://github.com/thoughtbot/continuous_sprinkles)
 - [Example nginx config](http://brainspl.at/nginx.conf.txt)
 - [sprinkle scripts](https://github.com/karmi/rails-deployment-setups-sprinkle)
 - [Tristan Dunn sprinkle linode setup](https://github.com/tristandunn/sprinkle-linode)
 - [Passenger stack video and site](http://benschwarz.github.com/passenger-stack/)
 - [Unicorn and rails detailed deployment guide](http://tech.tomgoren.com/archives/245)
 - Sprinkle [another Rails Nginx unicorn postgres stack](https://github.com/Shift81/sprinkler)
 - [Nginx+Unicorn configuration for multi-app servers](http://codetunes.com/2012/nginxunicorn-configuration-for-multi-app-servers)

#### Issues

On Ubuntu 10.04.4 LTS and Bundler 1.0.22 I was getting:
    `/usr/lib/ruby/gems/1.8/gems/bundler-1.0.22/bin/bundle:14: uninitialized constant Bundler (NameError)`

[Resolution is here](https://rails.lighthouseapp.com/projects/8994/tickets/3990-no-such-file-to-load-bundler-loaderror-in-rails-300beta#ticket-3990-20)

#### Running as root

Following SSH security practices, I disabled root logins via SSH after supplying my local public key to the remote server, and use public key-based authentication. Some of the ssh config file edits look like this:

    vim /etc/ssh/sshd_config
    PermitRootLogin no
    PasswordAuthentication no
    UsePAM no
    sudo /etc/init.d/ssh restart

You may need to run Sprinkle as connected via SSH as root if you aren't seeing any output, check [this issue](https://github.com/crafterm/sprinkle/issues/15#issuecomment-3749535).
