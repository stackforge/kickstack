class kickstack::ceilometer::agent::metering inherits kickstack {

  include kickstack::ceilometer::config
  include kickstack::ceilometer::auth

  class { '::ceilometer::collector': }

  class { '::ceilometer::agent::central':
    require => Class['::ceilometer::collector'],
  }

}
