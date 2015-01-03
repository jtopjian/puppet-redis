# == Class: redis::service
#
# The service configuration phase of the redis module
#
class redis::service {

  service { 'redis':
    ensure => $::redis::service_ensure,
    enable => $::redis::service_enable,
    name   => $::redis::service_name,
  }

}
