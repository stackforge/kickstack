class kickstack::node::orchestration inherits kickstack {

  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $heat_sql_conn = getvar("${fact_prefix}heat_sql_connection")
  $heat_keystone_password = getvar("${fact_prefix}heat_keystone_password")

  $apis = split($::kickstack::heat_apis,',')
  if 'heat' in $apis {
    $metadata_server = getvar("${fact_prefix}heat_metadata_server")
  }
  if 'cloudwatch' in $apis {
    $watch_server = getvar("${fact_prefix}heat_watch_server")
  }

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

  if $amqp_host and $amqp_password {
    if $heat_sql_conn and $heat_keystone_password {
      if $metadata_server or $watch_server {
        include kickstack::heat::engine
      }
    }
  }

}
