class kickstack::glance::api inherits kickstack {

  include kickstack::glance::config

  $auth_host = getvar("${fact_prefix}keystone_internal_address")
  $service_password = getvar("${fact_prefix}glance_keystone_password")
  $sql_conn = getvar("${fact_prefix}glance_sql_connection")
  $reg_host = getvar("${fact_prefix}glance_registry_host")

  class { '::glance::api':
    verbose           => $kickstack::verbose,
    debug             => $kickstack::debug,
    auth_type         => 'keystone',
    auth_host         => $auth_host,
    keystone_tenant   => $kickstack::keystone_service_tenant,
    keystone_user     => 'glance',
    keystone_password => $service_password,
    sql_connection    => $sql_conn,
    registry_host     => $reg_host,
  }

}
