class kickstack::node::api inherits kickstack {
  include kickstack::glance::api
  include kickstack::glance::endpoint

  include kickstack::cinder::api
  include kickstack::cinder::endpoint

  include kickstack::quantum::server
  include kickstack::quantum::endpoint
  include kickstack::quantum::plugin

  include kickstack::nova::api
  include kickstack::nova::endpoint
}
