require 'spec_helper'

describe 'redis' do

  context 'with defaults for all parameters' do

    # All classes
    it { should contain_class('redis') }
    it { should contain_class('redis::install') }
    it { should contain_class('redis::config') }
    it { should contain_class('redis::service') }

    # PPA
    it { should contain_apt__ppa('ppa:chris-lea/redis-server') }

    # Redis Package
    it { should contain_package('redis').with(:name => 'redis-server') }

    # Redis Service
    it { should contain_service('redis').with(:name => 'redis-server') }

    # Config notifies Service
    it { should contain_class('redis::config').that_notifies('Class[redis::service]') }

    # Config files
    it { should contain_file('/etc/redis').with(:ensure => 'directory') }
    it { should contain_file('/etc/redis/redis.conf').with(:owner => 'redis') }
    it { should contain_file('/etc/redis/save.conf').with(:owner => 'redis') }

    # Include setting
    it { should contain_file_line('/etc/redis/redis.conf include /etc/redis/save.conf') }

    # Save file contents
    it { should contain_file_line('/etc/redis/save.conf save 900 1') }

  end

end
