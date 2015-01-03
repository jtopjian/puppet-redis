# == Class: redis::repo
#
# Installs a repo if requested
#
class redis::repo {
  if $::redis::manage_repo {
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
}
