class kickstack::neutron::config inherits kickstack {

  $allow_overlapping_ips = "$::kickstack::neutron_network_type" ? {
    'single-flat' => false,
    'provider-router' => false,
    'per-tenant-router' => true,
  }

  $core_plugin = "$::kickstack::neutron_plugin" ? {
    'ovs' => 'neutron.plugins.openvswitch.ovs_neutron_plugin.OVSNeutronPluginV2',
    'linuxbridge'=> 'neutron.plugins.linuxbridge.lb_neutron_plugin.LinuxBridgePluginV2'
  }

  case "$::kickstack::rpc" {
    "rabbitmq": {
      $rabbit_host = getvar("${fact_prefix}rabbit_host")
      $rabbit_password = getvar("${fact_prefix}rabbit_password")
      if $rabbit_host and $rabbit_password {
        class { 'neutron':
          rpc_backend         => 'neutron.openstack.common.rpc.impl_kombu',
          rabbit_host         => "$rabbit_host",
          rabbit_virtual_host => "$::kickstack::rabbit_virtual_host",
          rabbit_user         => "$::kickstack::rabbit_userid",
          rabbit_password     => $rabbit_password,
          verbose             => $::kickstack::verbose,
          debug               => $::kickstack::debug,
          allow_overlapping_ips => $allow_overlapping_ips,
          core_plugin        => $core_plugin,
        }
      }
      else {
        warning("Facts ${fact_prefix}rabbit_host or ${fact_prefix}rabbit_password unset, cannot configure neutron")
      }
    }
    "qpid": {
      $qpid_hostname = getvar("${fact_prefix}qpid_hostname")
      $qpid_password = getvar("${fact_prefix}rabbit_password")
      if $qpid_hostname and $qpid_password {
        class { 'neutron':
          rpc_backend         => 'neutron.openstack.common.rpc.impl_qpid',
          qpid_hostname       => "$qpid_hostname",
          qpid_realm          => "$::kickstack::qpid_realm",
          qpid_username       => "$::kickstack::qpid_username",
          qpid_password       => $qpid_password,
          verbose             => $::kickstack::verbose,
          debug               => $::kickstack::debug,
          allow_overlapping_ips => $allow_overlapping_ips,
          core_plugin        => $core_plugin,
        }
      }
      else {
        warning("Facts ${fact_prefix}qpid_hostname or ${fact_prefix}qpid_password unset, cannot configure neutron")
      }
    }
  }
}
