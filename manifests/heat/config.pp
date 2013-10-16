class kickstack::heat::config inherits kickstack {
  include pwgen

  $admin_password = getvar("${fact_prefix}heat_keystone_password")
  $auth_host = getvar("${fact_prefix}keystone_internal_address")
  $auth_uri = "http://${auth_host}:5000/v2.0"

  $sql_conn = getvar("${fact_prefix}heat_sql_connection")

  case "$::kickstack::rpc" {
    'rabbitmq': {
      $rabbit_host = getvar("${::kickstack::fact_prefix}rabbit_host")
      $rabbit_password = getvar("${fact_prefix}rabbit_password")
      class { '::heat':
        package_ensure  => $::kickstack::package_version,
        auth_uri        => $auth_uri,
        sql_connection  => $sql_conn,
        rpc_backend     => 'heat.openstack.common.rpc.impl_kombu',
        rabbit_host     => $rabbit_host,
        rabbit_password => $rabbit_password,
        rabbit_virtualhost => $::kickstack::rabbit_virtual_host,
        rabbit_userid   => $::kickstack::rabbit_userid,
        keystone_host   => $auth_host,
        keystone_tenant => $kickstack::keystone_service_tenant,
        keystone_user   => 'heat',
        keystone_password => $admin_password,
        verbose         => $::kickstack::verbose,
        debug           => $::kickstack::debug,
      }
    }
    'qpid': {
      $qpid_hostname = getvar("${::kickstack::fact_prefix}qpid_hostname")
      $qpid_password = getvar("${fact_prefix}qpid_password")
      class { '::heat':
        package_ensure  => $::kickstack::package_version,
        sql_connection  => $sql_conn,
        auth_uri        => $auth_uri,
        rpc_backend     => 'heat.openstack.common.rpc.impl_qpid',
        qpid_hostname   => $qpid_hostname,
        qpid_password   => $qpid_password,
        qpid_realm      => $::kickstack::qpid_realm,
        qpid_user       => $::kickstack::qpid_user,
        keystone_host   => $auth_host,
        keystone_tenant => $kickstack::keystone_service_tenant,
        keystone_user   => 'heat',
        keystone_password => $admin_password,
        verbose         => $::kickstack::verbose,
        debug           => $::kickstack::debug,
      }
    }
  } 
}
