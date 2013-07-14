class kickstack::quantum::server inherits kickstack {

  include kickstack::quantum::config
  include pwgen

  $service_password = pick(getvar("${fact_prefix}quantum_keystone_password"),pwgen())
  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")

  class { '::quantum::server':
    auth_tenant   => $kickstack::keystone_service_tenant,
    auth_user     => 'quantum',
    auth_password => $service_password,
    auth_host     => $keystone_internal_address,
  }

  kickstack::endpoint { 'quantum':
    service_password => $service_password,
    require       => Class['::quantum::server']
  }

  kickstack::exportfact::export { "quantum_host":
    value => "${hostname}",
    tag => 'quantum',
    require => Class['::quantum::server']
  }

}
