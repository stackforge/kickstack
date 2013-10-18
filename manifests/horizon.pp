class kickstack::horizon inherits kickstack {

  $keystone_host = getvar("${::kickstack::fact_prefix}keystone_internal_address")
  $secret_key = getvar("${::kickstack::fact_prefix}horizon_secret_key")
  $new_secret_key = pick($secret_key,pwgen())

  package { 'memcached':
    ensure => installed;
  }

  if $::kickstack::debug {
    $django_debug = 'True'
    $log_level = 'DEBUG'
  } elsif $::kickstack::verbose {
    $django_debug = 'False'
    $log_level = 'INFO'
  } else {
    $django_debug = 'False'
    $log_level = 'WARNING'
  }

  class { '::horizon':
    require               => Package['memcached'],
    secret_key            => $new_secret_key,
    fqdn                  => $::kickstack::horizon_allow_any_hostname ? {
                               true => '*',
                               default => pick($fqdn,$hostname)
                             },
    cache_server_ip       => '127.0.0.1',
    cache_server_port     => '11211',
    swift                 => false,
    keystone_host         => $keystone_host,
    keystone_default_role => 'Member',
    django_debug          => $django_debug,
    api_result_limit      => 1000,
    log_level             => $log_level,
    can_set_mount_point   => 'True',
    listen_ssl            => false;
  }

  unless $secret_key == $new_secret_key {
    kickstack::exportfact::export { 'horizon_secret_key':
      value => $new_secret_key,
      tag => 'horizon',
      require => Class['::horizon']
    }
  }
}

