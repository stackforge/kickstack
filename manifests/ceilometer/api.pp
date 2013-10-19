class kickstack::ceilometer::api inherits kickstack {

  include kickstack::ceilometer::config
  include pwgen

  $auth_host = getvar("${fact_prefix}keystone_internal_address")
  $service_password = pick(getvar("${fact_prefix}ceilometer_keystone_password"),pwgen())
  $sql_conn = getvar("${fact_prefix}ceilometer_sql_connection")

  class { '::ceilometer::api':
    keystone_host     => $auth_host,
    keystone_tenant   => $kickstack::keystone_service_tenant,
    keystone_user     => 'ceilometer',
    keystone_password => $service_password,
  }

  kickstack::endpoint { 'ceilometer':
    service_password => $service_password,
    require          => Class['::ceilometer::api']
  }

  class { '::ceilometer::db':
    database_connection => $sql_conn,
  }
    
}
