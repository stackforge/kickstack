class kickstack::node::client inherits kickstack {
  include ::keystone::client
  include ::glance::client
  include ::cinder::client
  include ::neutron::client
  include ::heat::client
  include ::ceilometer::client
}
