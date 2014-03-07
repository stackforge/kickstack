class kickstack::neutron::agent::l2::network inherits kickstack {

  include kickstack::neutron::config

  $tenant_network_type = "$::kickstack::neutron_tenant_network_type"
  $external_bridge = $::kickstack::neutron_external_bridge

  case "$::kickstack::neutron_plugin" {
    'ovs': {
      case $tenant_network_type {
        'gre': {
          $local_tunnel_ip = getvar("ipaddress_${nic_data}")
          $bridge_uplinks = ["${external_bridge}:${nic_external}"]

          class { 'neutron::agents::ovs':
            bridge_mappings    => [],
            bridge_uplinks     => [],
            integration_bridge => $::kickstack::neutron_integration_bridge,
            enable_tunneling   => true,
            local_ip           => $local_tunnel_ip,
            tunnel_bridge      => $::kickstack::neutron_tunnel_bridge,
            tunnel_types       => ['gre'],
            require            => Class['::kickstack::neutron::agent::l3'],
            package_ensure => $::kickstack::package_version,
          }
        }
        default: {
          $bridge_uplinks = ["br-${nic_data}:${nic_data}"]
          unless $kickstack::neutron_network_type == 'single-flat' {
            $bridge_uplinks += ["${external_bridge}:${nic_external}"]
          }
          class { 'neutron::agents::ovs':
            bridge_mappings    => ["${::kickstack::neutron_physnet}:br-${nic_data}"],
            bridge_uplinks     => $bridge_uplinks,
            integration_bridge => $::kickstack::neutron_integration_bridge,
            enable_tunneling   => false,
            local_ip           => '',
            package_ensure => $::kickstack::package_version,
          }
        }
      }
    }
    'linuxbridge': {
      class { "neutron::agents::linuxbridge":
        physical_interface_mappings => "default:$nic_data",
        package_ensure => $::kickstack::package_version,
      }
    }
  } 
}
