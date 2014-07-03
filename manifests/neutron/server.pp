class kickstack::neutron::server inherits kickstack {

  include kickstack::neutron::config
  include pwgen

  $service_password = pick(getvar("${fact_prefix}neutron_keystone_password"),pwgen())
  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $database_connection = getvar("${fact_prefix}neutron_sql_connection")
  $nova_api_address = getvar("${fact_prefix}nova_api_address")

  class { '::neutron::server':
    auth_tenant   => $kickstack::keystone_service_tenant,
    auth_user     => 'neutron',
    auth_password => $service_password,
    auth_host     => $keystone_internal_address,
    database_connection => $database_connection,
    package_ensure => $::kickstack::package_version,
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
