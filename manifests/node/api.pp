class kickstack::node::api inherits kickstack {

  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $glance_sql_conn = getvar("${fact_prefix}glance_sql_connection")
  $cinder_sql_conn = getvar("${fact_prefix}cinder_sql_connection")
  $neutron_sql_conn = getvar("${fact_prefix}neutron_sql_connection")
  $nova_sql_conn = getvar("${fact_prefix}nova_sql_connection")
  $heat_sql_conn = getvar("${fact_prefix}heat_sql_connection")
  $ceilometer_sql_conn = getvar("${fact_prefix}ceilometer_sql_connection")

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
    include kickstack::neutron::server
    if $neutron_sql_conn {
      include kickstack::neutron::plugin
    }
  }

  if $keystone_internal_address and $nova_sql_conn and $amqp_host and $amqp_password {
    include kickstack::nova::api

    # This looks a bit silly, but is currently necessary: in order to configure nova-api
    # as a Neutron client, we first need to install nova-api and neutron-server in one
    # run, and then fix up Nova with the Neutron configuration in the next run.
    $neutron_keystone_password = getvar("${::kickstack::fact_prefix}neutron_keystone_password")
    if $neutron_keystone_password {
      include kickstack::nova::neutronclient
    }
  }

  if $keystone_internal_address and $heat_sql_conn and $amqp_host and $amqp_password {
    include kickstack::heat::api
  }

  if $keystone_internal_address and $ceilometer_sql_conn and $amqp_host and $amqp_password {
    include kickstack::ceilometer::api
  }
}
