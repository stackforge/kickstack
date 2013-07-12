class kickstack::node::auth inherits kickstack {
  include kickstack::keystone::api
  include kickstack::keystone::endpoint
}
