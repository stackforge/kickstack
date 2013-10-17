class kickstack::node::client inherits kickstack {
  include kickstack::keystone::client
  include kickstack::glance::client
  include kickstack::cinder::client
  include kickstack::quantum::client
}
