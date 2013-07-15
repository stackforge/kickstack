class kickstack::horizon inherits kickstack {

  $keystone_host = getvar("${fact_prefix}keystone_internal_address")
  $secret_key = pick(getvar("${fact_prefix}horizon_secret_key"),pwgen())

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
    secret_key            => $secret_key,
    cache_server_ip       => '127.0.0.1',
    cache_server_port     => '11211',
    swift                 => false,
    quantum               => true,
    keystone_host         => "$keystone_host",
    keystone_default_role => 'Member',
    django_debug          => $django_debug,
    api_result_limit      => 1000,
    log_level             => $log_level,
    can_set_mount_point   => 'True',
    listen_ssl            => false;
  }

  kickstack::exportfact::export { 'horizon_secret_key':
    value => $secret_key,
    tag => "horizon",
    require => Class['::horizon']
  }
}

