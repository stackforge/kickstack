class kickstack::quantum::plugin inherits kickstack {

  include kickstack::quantum::config

  $sql_conn = getvar("${fact_prefix}quantum_sql_connection")
  $tenant_network_type = "$::kickstack::quantum_tenant_network_type"
  $network_vlan_ranges = $tenant_network_type ? {
    'vlan' => "$::kickstack::quantum_network_vlan_ranges",
    'gre' => ''
  }
  $tunnel_id_ranges = $tenant_network_type ? {
    'vlan' => '',
    'gre' => "$::kickstack::quantum_tunnel_id_ranges"
  }

  case "$::kickstack::quantum_plugin" {
    'ovs': {
      class { "quantum::plugins::ovs":
        sql_connection => $sql_conn,
        tenant_network_type => $tenant_network_type,
        network_vlan_ranges => $network_vlan_ranges,
        tunnel_id_ranges => $tunnel_id_ranges
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
