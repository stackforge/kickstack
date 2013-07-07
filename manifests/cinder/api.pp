class kickstack::cinder::api inherits kickstack {

  include kickstack::cinder::config

  $service_password = getvar("${fact_prefix}cinder_keystone_password")
  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")

  class { '::cinder::api':
    keystone_tenant   => $kickstack::keystone_service_tenant,
    keystone_user     => 'cinder',
    keystone_password => $service_password,
    keystone_auth_host => $keystone_internal_address
  }

}
