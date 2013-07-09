class kickstack::node::controller inherits kickstack {

  include kickstack::glance::registry

  include kickstack::cinder::scheduler

  include kickstack::nova::cert
  include kickstack::nova::conductor
  include kickstack::nova::consoleauth
  include kickstack::nova::objectstore
  include kickstack::nova::scheduler

}
