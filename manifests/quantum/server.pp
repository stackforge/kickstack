class kickstack::quantum::server inherits kickstack {

  include kickstack::quantum::config

  $service_password = getvar("${fact_prefix}quantum_keystone_password")
  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")

  class { '::quantum::server':
    auth_tenant   => $kickstack::keystone_service_tenant,
    auth_user     => 'quantum',
    auth_password => $service_password,
    auth_host => $keystone_internal_address
  }

  kickstack::exportfact::export { "quantum_host":
    value => "${hostname}",
    tag => 'quantum',
    require => Class['::quantum::server']
  }

}
