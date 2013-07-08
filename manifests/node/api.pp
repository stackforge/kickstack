class kickstack::node::api inherits kickstack {
  include kickstack::keystone::api
  include kickstack::keystone::endpoint

  include kickstack::glance::api
  include kickstack::glance::endpoint

  include kickstack::cinder::api
  include kickstack::cinder::endpoint

  include kickstack::quantum::server
  include kickstack::quantum::endpoint
}
