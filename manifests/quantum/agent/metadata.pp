class kickstack::quantum::agent::metadata inherits kickstack {

  include kickstack::quantum::config
  include pwgen

  $secret = pick(getvar("${fact_prefix}quantum_metadata_shared_secret"),pwgen())

  $service_password = getvar("${fact_prefix}quantum_keystone_password")
  $metadata_ip = getvar("${fact_prefix}nova_metadata_ip")
  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")

  class { '::quantum::agents::metadata':
    shared_secret     => $secret,
    auth_password     => "$service_password",
    debug             => $kickstack::debug,
    auth_tenant       => "$kickstack::keystone_service_tenant",
    auth_user         => 'quantum',
    auth_url          => "http://${keystone_internal_address}:35357/v2.0", 
    auth_region       => "$kickstack::keystone_region",
    metadata_ip       => $metadata_ip
  }

  # Export the registry host name string for the service
  kickstack::exportfact::export { "quantum_metadata_shared_secret":
    value => "${secret}",
    tag => "quantum",
    require => Class['::quantum::agents::metadata']
  }

}
