class kickstack::node::auth inherits kickstack {

  $keystone_sql_conn = getvar("${fact_prefix}keystone_sql_connection")

  if $keystone_sql_conn {
    include kickstack::keystone::api
  }
}
