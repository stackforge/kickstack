class kickstack::node::controller inherits kickstack {

  include kickstack::glance::registry
  include kickstack::cinder::scheduler

}
