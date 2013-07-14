class kickstack::node::auth inherits kickstack {
  include kickstack::keystone::api
  include kickstack::keystone::endpoint
  include kickstack::glance::endpoint
  include kickstack::cinder::endpoint
  include kickstack::quantum::endpoint
  include kickstack::nova::endpoint
}
