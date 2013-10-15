class kickstack::nova::compute inherits kickstack {

  include kickstack::nova::config

  $keystone_internal_address = getvar("${fact_prefix}keystone_internal_address")
  $neutron_admin_password = getvar("${fact_prefix}neutron_keystone_password")
  $neutron_host = getvar("${fact_prefix}neutron_host")
  $vncproxy_host = getvar("${fact_prefix}vncproxy_host")
  $vncserver_listen_address = getvar("ipaddress_${::kickstack::nic_management}")

  class { '::nova::compute':
    enabled                       => true,
    vnc_enabled                   => true,
    vncserver_proxyclient_address => $vncserver_listen_address,
    vncproxy_host                 => $vncproxy_host,
    virtio_nic                    => true,
  }

  case "$::kickstack::nova_compute_driver" {
    'libvirt': {
      class { '::nova::compute::libvirt':
        libvirt_type => "$::kickstack::nova_compute_libvirt_type",
        vncserver_listen => $vncserver_listen_address
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
