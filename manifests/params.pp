# == Class: redis::params
#
# Operating system and distro-specific settings
#
class redis::params {

  case $::lsbdistid {

    'Ubuntu': {
      $package_name  = 'redis-server'
      $service_name  = 'redis-server'
      $tools_package = 'redis-tools'
    }

    default: {
      notify { "There are no parameters set for ${::lsbdistid}.": }
    }

  }

}
