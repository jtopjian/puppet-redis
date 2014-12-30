# puppet-redis

Installs and configures Redis.

## Setup

### Hiera

```yaml
redis::settings:
  bind: "%{::ipaddress_eth0}"
  dbfilename: "%{::hostname}.db"
redis::settings::save:
  '900 1': 'present'
  '300 10': 'present'
  '60 10000': 'present'
```

### Puppet

```puppet
class site::profiles::redis::server {

  # Hiera
  $redis_user          = hiera('redis::user', 'redis')
  $redis_group         = hiera('redis::group', 'redis')
  $redis_settings      = hiera_hash('redis::settings')
  $redis_save_settings = hiera_hash('redis::settings::save')

  # Resources
  anchor { 'site::profiles::redis::server::begin': } ->
  class { '::redis':
    user          => $redis_user,
    group         => $redis_group,
    settings      => $redis_settings,
    save_settings => $redis_save_settings,
  } ->
  anchor { 'site::profiles::redis::server::end': }

}
```
