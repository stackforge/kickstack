class kickstack::cinder::api inherits kickstack {

  include kickstack::cinder::config
  include pwgen

  $service_password = pick(getvar("${fact_prefix}cinder_keystone_password"),pwgen())
  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")

  class { '::cinder::api':
    keystone_tenant   => $kickstack::keystone_service_tenant,
    keystone_user     => 'cinder',
    keystone_password => $service_password,
    keystone_auth_host => $keystone_internal_address,
    package_ensure => $::kickstack::package_version,
  }

  kickstack::endpoint { 'cinder':
    service_password => $service_password,
    require           => Class['::cinder::api']
  }
}
