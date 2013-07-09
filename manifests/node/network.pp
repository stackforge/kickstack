class kickstack::node::network inherits kickstack {
  include kickstack::quantum::agent::l2
  include kickstack::quantum::agent::dhcp
  include kickstack::quantum::agent::l3
  include kickstack::quantum::agent::metadata
}
