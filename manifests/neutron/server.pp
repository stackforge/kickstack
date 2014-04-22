class kickstack::neutron::server inherits kickstack {

  include kickstack::neutron::config
  include pwgen

  $service_password = pick(getvar("${fact_prefix}neutron_keystone_password"),pwgen())
  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $database_connection = getvar("${fact_prefix}neutron_sql_connection")
  $nova_service_password = pick(getvar("${fact_prefix}nova_keystone_password"))
  $nova_api_address = getvar("${fact_prefix}nova_api_address")

  class { '::neutron::server':
    auth_tenant   => $kickstack::keystone_service_tenant,
    auth_user     => 'neutron',
    auth_password => $service_password,
    auth_host     => $keystone_internal_address,
    database_connection => $database_connection,
    package_ensure => $::kickstack::package_version,
  }

  class { '::neutron::server::notifications':
    nova_url               => "http://${nova_api_address}:8774/v2",
    nova_admin_username    => 'nova',
    nova_admin_tenant_name => $kickstack::keystone_service_tenant,
    nova_admin_password    => $nova_service_password,
    nova_admin_auth_url    => "http://${keystone_internal_address}:35357/v2.0",
    nova_region_name       => $kickstack::params::keystone_region,
    require                => Class['::nova::api']
  }

  kickstack::endpoint { 'neutron':
    service_password => $service_password,
    require       => Class['::neutron::server']
  }

  kickstack::exportfact::export { "neutron_host":
    value => "${hostname}",
    tag => 'neutron',
    require => Class['::neutron::server']
  }

  case $::osfamily {
    'Debian': {
      file { 'neutron-server-default':
        path => '/etc/default/neutron-server',
        content => template("kickstack/default.neutron-server.erb"),
      }
    }
  }
}
