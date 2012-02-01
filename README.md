My rails appserver setup scripts using Sprinkle

What does it install?
---------------------
 - apt package manager
 - iptables
 - memcached
 - nginx
 - redis
 - ruby
 - mysql
 - git
 
Test the configuration
----------------------
    sprinkle -s install.rb -t
 
Installation
------------
  setup: the memcache package right now as a deploy:deploy user and group, so you will have to `adduser deploy` on the box
  or change that as necessary. 
  
  1. `gem install sprinkle`
  2. `cp deploy.example.rb deploy.rb` and customize.
  3. `sprinkle -c -s install.rb`

Additional reading, sources for these scripts, attribution and thanks
---------------------------------------------------------------------
 - `sprinkle --help`
 - [Sprinkle Documentation](http://rubydoc.info/github/crafterm/sprinkle/master)
 - Thoughtbot [Sprinkle scripts](https://github.com/thoughtbot/continuous_sprinkles)
 - [Example nginx config](http://brainspl.at/nginx.conf.txt)
 - https://github.com/karmi/rails-deployment-setups-sprinkle.git
 - [Tristan Dunn sprinkle linode setup](https://github.com/tristandunn/sprinkle-linode)
 - [Passenger stack video and site](http://benschwarz.github.com/passenger-stack/)
 
 
Running as root
---------------
Following SSH security practices, I disabled root logins via SSH after supplying my local public key to the remote server, and use public key-based authentication. Some of the ssh config file edits look like this:

    vim /etc/ssh/sshd_config
    PermitRootLogin no
    PasswordAuthentication no
    UsePAM no
    sudo /etc/init.d/ssh restart
    
You may need to run Sprinkle as connected via SSH as root if you aren't seeing any output, check this issue. 

https://github.com/crafterm/sprinkle/issues/15#issuecomment-3749535