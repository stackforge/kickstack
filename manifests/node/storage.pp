class kickstack::node::storage inherits kickstack {

  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $cinder_sql_conn = getvar("${fact_prefix}cinder_sql_connection")
  $cinder_keystone_password = getvar("${fact_prefix}cinder_keystone_password")

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

  if $keystone_internal_address and $cinder_sql_conn and $cinder_keystone_password and $amqp_host and $amqp_password {
    include kickstack::cinder::volume
  }
}
