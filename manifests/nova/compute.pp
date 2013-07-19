class kickstack::nova::compute inherits kickstack {

  include kickstack::nova::config

  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $quantum_admin_password = getvar("${fact_prefix}quantum_keystone_password")
  $quantum_host = getvar("${fact_prefix}quantum_host")
  $vncproxy_host = getvar("${fact_prefix}vncproxy_host")

  class { '::nova::compute':
    enabled                       => true,
    vnc_enabled                   => true,
    vncserver_proxyclient_address => getvar("ipaddress_${::kickstack::nic_management}"),
    vncproxy_host                 => $vncproxy_host,
    virtio_nic                    => true,
  }

  case "$::kickstack::nova_compute_driver" {
    'libvirt': {
      class { '::nova::compute::libvirt':
        libvirt_type => "$::kickstack::nova_compute_libvirt_type",
        vncserver_listen => '0.0.0.0'
      }
    }
    'xenserver': {
      class { '::nova::compute::xenserver':
        xenapi_connection_url => "$::kickstack::nova_compute_xenapi_connection_url",
        xenapi_connection_username => "$::kickstack::nova_compute_xenapi_connection_username",
        xenapi_connection_password => "$::kickstack::nova_compute_xenapi_connection_password"
      }
    }
  }

}
