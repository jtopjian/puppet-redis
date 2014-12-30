# == Class: redis::service
#
# The service configuration phase of the redis module
#
class redis::service {

  include redis::params

  service { 'redis':
    ensure => $::redis::service_ensure,
    enable => $::redis::service_enable,
    name   => $::redis::params::service_name,
  }

}
