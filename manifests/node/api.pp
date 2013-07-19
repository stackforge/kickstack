class kickstack::node::api inherits kickstack {

  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $glance_sql_conn = getvar("${fact_prefix}glance_sql_connection")
  $cinder_sql_conn = getvar("${fact_prefix}cinder_sql_connection")
  $quantum_sql_conn = getvar("${fact_prefix}quantum_sql_connection")
  $nova_sql_conn = getvar("${fact_prefix}nova_sql_connection")
  

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

  if $keystone_internal_address and $glance_sql_conn {
    include kickstack::glance::api
  }

  if $keystone_internal_address and $cinder_sql_conn and $amqp_host and $amqp_password {
    include kickstack::cinder::api
  }

  if $keystone_internal_address and $amqp_host and $amqp_password {
    include kickstack::quantum::server
    if $quantum_sql_conn {
      include kickstack::quantum::plugin
    }
  }

  if $keystone_internal_address and $nova_sql_conn and $amqp_host and $amqp_password {
    include kickstack::nova::api

    # This looks a bit silly, but is currently necessary: in order to configure nova-api
    # as a Quantum client, we first need to install nova-api and quantum-server in one
    # run, and then fix up Nova with the Quantum configuration in the next run.
    $quantum_keystone_password = getvar("${::kickstack::fact_prefix}quantum_keystone_password")
    if $quantum_keystone_password {
      include kickstack::nova::quantumclient
    }
  }
}
