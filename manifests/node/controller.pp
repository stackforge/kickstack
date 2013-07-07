class kickstack::node::controller inherits kickstack {

  include kickstack::rpc
  include kickstack::database

  kickstack::db::service { ['keystone','glance','cinder','nova']: }

  include kickstack::glance::registry
}
