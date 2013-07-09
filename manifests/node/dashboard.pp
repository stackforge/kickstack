class kickstack::node::dashboard inherits kickstack {
  include kickstack::horizon
  include kickstack::nova::vncproxy
}
