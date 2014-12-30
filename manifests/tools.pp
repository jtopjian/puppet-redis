# == Class: redis::tools
#
# Installs the redis-tools package
#
class redis::tools (
  $package_ensure = 'latest',
) {

  include redis::params

  package { 'redis-tools':
    ensure => $package_ensure,
    name   => $::redis::params::tools_package,
  }

}
