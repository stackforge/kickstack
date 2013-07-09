class kickstack::node::compute inherits kickstack {
  include kickstack::quantum::agent::l2
  include kickstack::nova::compute
}
