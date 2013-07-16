class kickstack::quantum::agent::l3 inherits kickstack {

  include kickstack::quantum::config

  class { "vswitch::bridge":
    name => 'br-ex'
  } 

  class { "::quantum::agents::l3":
    debug            => $::kickstack::debug,
    interface_driver => $::kickstack::quantum_plugin ? {
                          'ovs' => 'quantum.agent.linux.interface.OVSInterfaceDriver',
                          'linuxbridge' => 'quantum.agent.linux.interface.BridgeInterfaceDriver'
                        },
    external_network_bridge => $::kickstack::quantum_external_bridge,
    use_namespaces   => $::kickstack::quantum_network_type ? {
                          'per-tenant-router' => true,
                          default => false
                        },
    router_id        => $::kickstack::quantum_network_type ? {
                          'provider-router' => "$::kickstack::quantum_router_id",
                          default => undef
                        },
    gateway_external_network_id => $::kickstack::quantum_network_type ? {
                          'provider-router' => "$::kickstack::quantum_gateway_external_network_id",
                          default => undef
                        },
    require => Class['kickstack::quantum::agent::metadata','vswitch::bridge']
  }
}
