class kickstack::glance::api inherits kickstack {

  include kickstack::glance::config
  include pwgen

  $auth_host = getvar("${fact_prefix}keystone_internal_address")
  $service_password = pick(getvar("${fact_prefix}glance_keystone_password"),pwgen())
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

  kickstack::endpoint { 'glance':
    service_password => $service_password,
    require          => Class['::glance::api']
  }

  kickstack::exportfact::export { 'glance_api_host':
    value => $hostname,
    tag => 'glance',
    require => Class['::glance::api']
  }
}
