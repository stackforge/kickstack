class kickstack::quantum::plugin inherits kickstack {

  include kickstack::quantum::config

  $sql_conn = getvar("${fact_prefix}quantum_sql_connection")
  $tenant_network_type = "$::kickstack::quantum_tenant_network_type"
  $network_vlan_ranges = $tenant_network_type ? {
    'gre' => '',
    default => "${::kickstack::quantum_physnet}:${::kickstack::quantum_network_vlan_ranges}",
  }
  $tunnel_id_ranges = $tenant_network_type ? {
    'gre' => $::kickstack::quantum_tunnel_id_ranges,
    default => '',
  }

  case "$::kickstack::quantum_plugin" {
    'ovs': {
      class { "quantum::plugins::ovs":
        sql_connection => $sql_conn,
        tenant_network_type => $tenant_network_type,
        network_vlan_ranges => $network_vlan_ranges,
        tunnel_id_ranges => $tunnel_id_ranges
      }
      # This needs to be set for the plugin, not the agent
      # (the latter is what the Quantum module assumes)
      quantum_plugin_ovs { 'SECURITYGROUP/firewall_driver':
        value => 'quantum.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver',
        require => Class['quantum::plugins::ovs']
      }
    }
    'linuxbridge': {
      class { "quantum::plugins::linuxbridge":
        sql_connection => $sql_conn,
        tenant_network_type => $tenant_network_type,
        network_vlan_ranges => $network_vlan_ranges,
      }
    }
  } 
}
