# == Class: redis::tools
#
# Installs the redis-tools package
#
class redis::tools (
  $package_ensure = 'latest',
) {

  package { 'redis-tools':
    ensure => $package_ensure,
    name   => $::redis::tools_package,
  }

}
