class kickstack::node::api inherits kickstack {
  include kickstack::glance::api

  include kickstack::cinder::api

  include kickstack::quantum::server
  include kickstack::quantum::plugin

  include kickstack::nova::api
}
