class kickstack::node::controller inherits kickstack {

  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $glance_sql_conn = getvar("${fact_prefix}glance_sql_connection")
  $glance_keystone_password = getvar("${fact_prefix}glance_keystone_password")
  $cinder_sql_conn = getvar("${fact_prefix}cinder_sql_connection")
  $cinder_keystone_password = getvar("${fact_prefix}cinder_keystone_password")
  $nova_sql_conn = getvar("${fact_prefix}nova_sql_connection")
  $nova_keystone_password = getvar("${fact_prefix}nova_keystone_password")
  $neutron_sql_conn = getvar("${fact_prefix}neutron_sql_connection")
  $neutron_keystone_password = getvar("${fact_prefix}neutron_keystone_password")

  case $::kickstack::rpc {
    'rabbitmq': {
      $amqp_host = getvar("${::kickstack::fact_prefix}rabbit_host")
      $amqp_password = getvar("${::kickstack::fact_prefix}rabbit_password")
    }
    'qpid': {
      $amqp_host = getvar("${::kickstack::fact_prefix}qpid_host")
      $amqp_password = getvar("${::kickstack::fact_prefix}qpid_password")
    }
  }

  if $glance_sql_conn and $glance_keystone_password {
    include kickstack::glance::registry
  }

  if $amqp_host and $amqp_password {
    if $cinder_sql_conn and $cinder_keystone_password {
      include kickstack::cinder::scheduler
    }
    if $nova_sql_conn and $nova_keystone_password {
      include kickstack::nova::cert
      include kickstack::nova::conductor
      include kickstack::nova::consoleauth
      include kickstack::nova::objectstore
      include kickstack::nova::scheduler
    }
  }

}
