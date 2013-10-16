class kickstack::neutron::agent::l3 inherits kickstack {

  include kickstack::neutron::config

  class { "vswitch::bridge":
    name => 'br-ex'
  } 

  class { "::neutron::agents::l3":
    debug            => $::kickstack::debug,
    interface_driver => $::kickstack::neutron_plugin ? {
                          'ovs' => 'neutron.agent.linux.interface.OVSInterfaceDriver',
                          'linuxbridge' => 'neutron.agent.linux.interface.BridgeInterfaceDriver'
                        },
    external_network_bridge => $::kickstack::neutron_external_bridge,
    use_namespaces   => $::kickstack::neutron_network_type ? {
                          'per-tenant-router' => true,
                          default => false
                        },
    router_id        => $::kickstack::neutron_network_type ? {
                          'provider-router' => "$::kickstack::neutron_router_id",
                          default => undef
                        },
    gateway_external_network_id => $::kickstack::neutron_network_type ? {
                          'provider-router' => "$::kickstack::neutron_gateway_external_network_id",
                          default => undef
                        },
    package_ensure => $::kickstack::package_version,
    require => Class['vswitch::bridge'],
  }
}
