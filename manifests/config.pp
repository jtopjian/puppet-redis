# == Class: redis::config
#
# The configuration phase of the redis module
#
class redis::config {

  $redis_conf = "${::redis::config_dir}/redis.conf"
  $save_conf  = "${::redis::config_dir}/save.conf"

  File {
    ensure => present,
    owner  => $::redis::user,
    group  => $::redis::group,
    mode   => '0640',
  }

  file { $::redis::config_dir:
    ensure => directory,
  }
  file { $redis_conf: }
  file { $save_conf: }

  exec { "remove save settings from ${redis_conf}":
    path    => ['/bin'],
    command => "sed -i -e '/^save /d' ${redis_conf}",
    onlyif  => "grep ^save ${redis_conf}",
  }

  file_line { "${redis_conf} include ${save_conf}":
    path => $redis_conf,
    line => "include ${save_conf}",
  }

  $::redis::settings.each |$key, $value| {
    file_line { "${redis_conf} ${key} = ${value}":
      path  => $redis_conf,
      line  => "${key} ${value}",
      match => "^${key} ",
    }
  }

  $::redis::save_settings.each |$setting, $ensure| {
    file_line { "${save_conf} save ${setting}":
      ensure => $ensure,
      path   => $save_conf,
      line   => "save ${setting}",
    }
  }

}
