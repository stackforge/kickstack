class kickstack::heat::engine inherits kickstack {

  include pwgen
  include ::kickstack::heat::config

  $heat_auth_encryption_key = pick(getvar("${fact_prefix}heat_auth_encryption_key"),pwgen())
  $apis = split($::kickstack::heat_apis,',')

  kickstack::exportfact::export { 'heat_auth_encryption_key':
    value => $heat_auth_encryption_key,
    tag => 'heat'
  }

  if 'heat' in $apis {
    $metadata_server = getvar("${fact_prefix}heat_metadata_server")
    $metadata_server_url = "http://${metadata_server}:8000"
    $waitcondition_server_url = "http://${metadata_server}:8000/v1/waitcondition"
  }

  if 'cloudwatch' in $apis {
    $watch_server = getvar("${fact_prefix}heat_watch_server")
    $watch_server_url = "http://${watch_server}:8003"
  }

  if $apis {
    class { '::heat::engine':
      heat_metadata_server_url => $metadata_server_url,
      heat_waitcondition_server_url => $waitcondition_server_url,
      heat_watch_server_url => $watch_server_url,
      auth_encryption_key => $heat_auth_encryption_key,
    }
  }
  
}
