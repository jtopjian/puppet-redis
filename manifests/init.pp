# == Class: redis
#
# Installs and configures Redis.
#
# === Parameters
#
# [*package_ensure*]
#   The ensure status of the package.
#
# [*use_repo*]
#   Whether or not to install Redis from a third-party repo.
#
# [*user*]
#   The user to run redis as.
#
# [*group*]
#   The group to run redis as.
#
# [*config_dir*]
#   The directory to put config files.
#
# [*service_ensure*]
#   The ensure status of the service.
#
# [*service_enable*]
#   The enable status of the service.
#
# [*reload_service*]
#   Whether or not config changes cause the service to restart.
#
# [*settings*]
#   A hash of settings.
#
# [*save_settings*]
#   The values of the `save` settings.
#
# === Examples
#
# See the README file.
#
# === Authors
#
# Joe Topjian <joe@topjian.net>
#
# === Copyright
#
# Copyright 2014 Joe Topjian
#
class redis (
  $package_ensure = 'latest',
  $use_repo       = true,
  $user           = 'redis',
  $group          = 'redis',
  $config_dir     = '/etc/redis',
  $service_ensure = 'running',
  $service_enable = true,
  $reload_service = true,
  $settings       = {},
  $save_settings  = { '900 1' => 'present', '300 10' => 'present', '60 1000' => 'present' },
) {

  anchor { 'redis::begin': } ->
  class { 'redis::install': } ->
  class { 'redis::config': } ->
  class { 'redis::service': } ->
  anchor { 'redis::end': }

  if $reload_service {
    Class['redis::config'] ~> Class['redis::service']
  }

}
