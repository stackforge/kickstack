class kickstack::node::controller inherits kickstack {

  include kickstack::rpc
  include kickstack::database

  include kickstack::keystone::db

  include kickstack::glance::db
  include kickstack::glance::registry
  
  include kickstack::cinder::db
  include kickstack::cinder::scheduler

  include kickstack::quantum::db

  include kickstack::nova::db
}
