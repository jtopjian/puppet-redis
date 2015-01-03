# == Class: redis::params
#
# OS/Distro-specific and Default settings
#
class redis::params {

  # OS/Distro-specific
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

  # All other settings

  ## package
  $manage_repo    = true
  $package_ensure = 'latest'

  ## user/group
  $user  = 'redis'
  $group = 'redis'

  ## config
  $config_dir    = '/etc/redis'
  $settings      = {}
  $save_settings = { '900 1' => 'present', '300 10' => 'present', '60 1000' => 'present' }

  ## service
  $service_ensure = 'running'
  $service_enable = true
  $reload_service = true

}
