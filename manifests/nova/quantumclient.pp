class kickstack::nova::quantumclient inherits kickstack {

  include kickstack::nova::config

  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $quantum_admin_password = getvar("${fact_prefix}quantum_keystone_password")
  $quantum_host = getvar("${fact_prefix}quantum_host")

  class { '::nova::network::quantum':
    quantum_admin_password    => $quantum_admin_password,
    quantum_auth_strategy     => 'keystone',
    quantum_url               => "http://${quantum_host}:9696",
    quantum_admin_tenant_name => "$::kickstack::keystone_service_tenant",
    quantum_region_name       => "$::kickstack::keystone_region",
    quantum_admin_username    => 'quantum',
    quantum_admin_auth_url    => "http://${keystone_internal_address}:35357/v2.0",
    security_group_api        => 'quantum',
  }
}
