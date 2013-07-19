class kickstack::node::compute inherits kickstack {

  # Compute nodes require AMQP connectivity, 
  # a nova Keystone endpoint, an SQL connection,
  # and a glance API server

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

  $nova_sql_conn = getvar("${::kickstack::fact_prefix}nova_sql_connection")
  $nova_keystone_password = getvar("${::kickstack::fact_prefix}nova_keystone_password")
  $quantum_keystone_password = getvar("${::kickstack::fact_prefix}quantum_keystone_password")
  $glance_api_host = getvar("${::kickstack::fact_prefix}glance_api_host")

  if $amqp_host and $amqp_password {
    include kickstack::quantum::agent::l2::compute
    if $nova_sql_conn and $nova_keystone_password and $glance_api_host {
      include kickstack::nova::compute
    }
    if $quantum_keystone_password {
      include kickstack::nova::quantumclient
    }
  }
}
