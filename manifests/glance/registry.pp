class kickstack::glance::registry inherits kickstack {

  include kickstack::glance::config

  $service_password = getvar("${fact_prefix}glance_keystone_password")
  $sql_conn = getvar("${fact_prefix}glance_sql_connection")
  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")

  class { '::glance::registry':
    verbose           => $kickstack::verbose,
    debug             => $kickstack::debug,
    auth_host         => "$keystone_internal_address", 
    keystone_tenant   => "$keystone_service_tenant",
    keystone_user     => 'glance',
    keystone_password => "$service_password",
    sql_connection    => "$sql_conn",
  }

  # Export the registry host name string for the service
  kickstack::exportfact::export { "glance_registry_host":
    value => "${hostname}",
    tag => "glance",
    require => Class['::glance::registry']
  }

}
