class kickstack::node::network inherits kickstack {

  # Network nodes require a quantum Keystone endpoint.
  # The L2 agents need an SQL connection.
  # The metadata agent also requires the shared secret set by Nova API.

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

  $quantum_sql_conn = getvar("${::kickstack::fact_prefix}quantum_sql_connection")
  $quantum_keystone_password = getvar("${::kickstack::fact_prefix}quantum_keystone_password")
  $quantum_metadata_shared_secret = getvar("${::kickstack::fact_prefix}quantum_metadata_shared_secret")

  if $amqp_host and $amqp_password and $quantum_keystone_password {
    include kickstack::quantum::agent::dhcp
    include kickstack::quantum::agent::l3
    if $quantum_sql_conn {
      include kickstack::quantum::agent::l2
    }
    if $quantum_metadata_shared_secret {
      include kickstack::quantum::agent::metadata
    }
  }
}
