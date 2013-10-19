class kickstack::ceilometer::agent::compute inherits kickstack {

  include kickstack::ceilometer::config
  include kickstack::ceilometer::auth

  class { '::ceilometer::agent::compute': }

}
