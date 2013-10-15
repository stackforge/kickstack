class kickstack::node::network inherits kickstack {

  # Network nodes require a neutron Keystone endpoint.
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
    default: {
      fail("Unsupported value for \$::kickstack::rpc: $::kickstack::rpc")
    }
  }

  $neutron_sql_conn = getvar("${::kickstack::fact_prefix}neutron_sql_connection")
  $neutron_keystone_password = getvar("${::kickstack::fact_prefix}neutron_keystone_password")
  $neutron_metadata_shared_secret = getvar("${::kickstack::fact_prefix}neutron_metadata_shared_secret")

  if $amqp_host and $amqp_password and $neutron_keystone_password {
    include kickstack::neutron::agent::dhcp
    include kickstack::neutron::agent::l3
    if $neutron_sql_conn {
      include kickstack::neutron::agent::l2::network
    }
    if $neutron_metadata_shared_secret {
      include kickstack::neutron::agent::metadata
    }
  }
}
