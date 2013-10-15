class kickstack::nova::neutronclient inherits kickstack {

  include kickstack::nova::config

  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $neutron_admin_password = getvar("${fact_prefix}neutron_keystone_password")
  $neutron_host = getvar("${fact_prefix}neutron_host")

  class { '::nova::network::neutron':
    neutron_admin_password    => $neutron_admin_password,
    neutron_auth_strategy     => 'keystone',
    neutron_url               => "http://${neutron_host}:9696",
    neutron_admin_tenant_name => "$::kickstack::keystone_service_tenant",
    neutron_region_name       => "$::kickstack::keystone_region",
    neutron_admin_username    => 'neutron',
    neutron_admin_auth_url    => "http://${keystone_internal_address}:35357/v2.0",
    security_group_api        => 'neutron',
  }
}
