class kickstack::cloudcontroller inherits kickstack {

  include kickstack::rpc
  include kickstack::db

  kickstack::db::service { ['keystone','glance','cinder','nova']: }

}
