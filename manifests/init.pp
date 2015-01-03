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
  $package_ensure = $redis::params::package_ensure,
  $manage_repo    = $redis::params::manage_repo,
  $user           = $redis::params::user,
  $group          = $redis::params::group,
  $config_dir     = $redis::params::config_dir,
  $settings       = $redis::params::settings,
  $save_settings  = $redis::params::save_settings,
  $service_ensure = $redis::params::service_ensure,
  $service_enable = $redis::params::service_enable,
  $reload_service = $redis::params::reload_service,
) inherits redis::params {

  anchor { 'redis::begin': } ->
  class { 'redis::repo': } ->
  class { 'redis::install': } ->
  class { 'redis::config': } ->
  class { 'redis::service': } ->
  anchor { 'redis::end': }

  if $reload_service {
    Class['redis::config'] ~> Class['redis::service']
  }

}
