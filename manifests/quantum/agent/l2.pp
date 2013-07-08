class kickstack::quantum::agent::l2 inherits kickstack {

  include kickstack::quantum::config

  $tenant_network_type = "$::kickstack::quantum_tenant_network_type"

  case "$::kickstack::quantum_plugin" {
    'ovs': {
      case $tenant_network_type {
        'gre': {
          $local_tunnel_ip = getvar("ipaddress_${nic_data}")
          class { 'quantum::agents::ovs':
            integration_bridge => 'br-int',
            enable_tunneling   => true,
            local_ip           => $local_tunnel_ip,
            tunnel_bridge      => 'br-tun',
          }
        }
        'vlan': {
          class { 'quantum::agents::ovs':
            bridge_mappings    => ["default:br-${nic_data}"],
            bridge_uplinks     => ["br-${nic_data}:${nic_data}"],
            integration_bridge => 'br-int',
            enable_tunneling   => false,
            local_ip           => '',
          }
        }
      }
    }
    'linuxbridge': {
      class { "quantum::agents::linuxbridge":
        physical_interface_mappings => "default:$nic_data"
      }
    }
  } 
}
