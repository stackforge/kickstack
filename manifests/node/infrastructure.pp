class kickstack::node::infrastructure inherits kickstack {

  include kickstack::rpc
  include kickstack::database

  include kickstack::keystone::db
  include kickstack::glance::db
  include kickstack::cinder::db
  include kickstack::neutron::db
  include kickstack::nova::db

  if $::kickstack::heat_apis {
    include kickstack::heat::db
  }

  include kickstack::ceilometer::db
}
