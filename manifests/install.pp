# == Class: redis::install
#
# The install phase of the redis module
#
class redis::install {

  package { 'redis':
    ensure => $::redis::package_ensure,
    name   => $::redis::package_name,
  }

}
