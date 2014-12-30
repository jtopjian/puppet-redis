# == Class: redis::install
#
# The install phase of the redis module
#
class redis::install {

  include redis::params

  if $::redis::use_repo == true {
    case $::lsbdistid {
      'Ubuntu': {
        apt::ppa { 'ppa:chris-lea/redis-server':
          before => Package['redis'],
        }
      }
      default: {
        notify { "There is not a repo configured for ${::lsbdistid}.": }
      }
    }
  }

  package { 'redis':
    ensure => $::redis::package_ensure,
    name   => $::redis::params::package_name,
  }

}
