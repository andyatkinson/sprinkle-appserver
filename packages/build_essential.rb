package :build_essential do
  describe 'Build tools'
  apt 'build-essential zlib1g-dev libssl-dev libreadline5-dev libcurl4-openssl-dev' do
    pre :install, 'apt-get -y update',
                  'apt-get -y dist-upgrade'
  end
end

package :libmysql do
  apt 'libmysqlclient15-dev'
end

package :libssl do
  apt 'libssl-dev'
end

package :htop do
  apt 'htop'

  verify do
    has_executable 'htop'
  end
end