class kickstack::quantum::agent::dhcp inherits kickstack {

  include kickstack::quantum::config

  class { "::quantum::agents::dhcp":
    debug            => $::kickstack::debug,
    interface_driver => $::kickstack::quantum_plugin ? {
                          'ovs' => 'quantum.agent.linux.interface.OVSInterfaceDriver',
                          'linuxbridge' => 'quantum.agent.linux.interface.BridgeInterfaceDriver'
                        },
    use_namespaces   => $::kickstack::quantum_network_type ? {
                          'per-tenant-router' => true,
                          default => false
                        }
  }
} 
