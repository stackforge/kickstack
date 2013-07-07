class kickstack::glance::api inherits kickstack {

  include kickstack::glance::config

  # Grab the Keystone admin token from a kickstack fact and configure
  # Keystone accordingly. If no fact has been set, generate a password.
  $service_password = getvar("${fact_prefix}glance_keystone_password")
  $sql_conn = getvar("${fact_prefix}glance_sql_connection")

  class { '::glance::api':
    verbose           => $kickstack::verbose,
    debug             => $kickstack::debug,
    keystone_tenant   => $kickstack::keystone_service_tenant,
    keystone_user     => 'glance',
    keystone_password => $service_password,
    sql_connection    => $sql_conn,
  }

}
