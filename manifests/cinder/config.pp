class kickstack::cinder::config inherits kickstack {

  $sql_conn = getvar("${fact_prefix}cinder_sql_connection")

  case "$::kickstack::rpc" {
    "rabbitmq": {
      $rabbit_host = getvar("${fact_prefix}rabbit_host")
      $rabbit_password = getvar("${fact_prefix}rabbit_password")
      if $rabbit_host and $rabbit_password {
        class { 'cinder':
          sql_connection      => "$sql_conn",
          rpc_backend         => 'cinder.openstack.common.rpc.impl_kombu',
          rabbit_host         => "$rabbit_host",
          rabbit_virtual_host => "$::kickstack::rabbit_virtual_host",
          rabbit_userid       => "$::kickstack::rabbit_userid",
          rabbit_password     => $rabbit_password,
          verbose             => $::kickstack::verbose,
          debug               => $::kickstack::debug,
        }
      }
      else {
        warning("Facts ${fact_prefix}rabbit_host or ${fact_prefix}rabbit_password unset, cannot configure cinder")
      }
    }
    "qpid": {
      $qpid_hostname = getvar("${fact_prefix}qpid_hostname")
      $qpid_password = getvar("${fact_prefix}rabbit_password")
      if $qpid_hostname and $qpid_password {
        class { 'cinder':
          sql_connection      => "$sql_conn",
          rpc_backend         => 'cinder.openstack.common.rpc.impl_qpid',
          qpid_hostname       => "$qpid_hostname",
          qpid_realm          => "$::kickstack::qpid_realm",
          qpid_username       => "$::kickstack::qpid_username",
          qpid_password       => $qpid_password,
          verbose             => $::kickstack::verbose,
          debug               => $::kickstack::debug,
        }
      }
      else {
        warning("Facts ${fact_prefix}qpid_hostname or ${fact_prefix}qpid_password unset, cannot configure cinder")
      }
    }
  }
}
