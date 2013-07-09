# Class: kickstack
#
# This module manages kickstack, a thin wrapper around the Stackforge
# Puppet modules that enables easy deployment with any Puppet External
# Node Classifier (ENC), such as Puppet Dashboard, Puppet Enterprise,
# or The Foreman.
#
# Parameters:
#   fact_prefix - Prefix to be used for the facts passed around
#     between various nodes in the kickstack installation. If your
#     Puppet environment manages only one single kickstack deployment,
#     there is no need to change this. However, if you use one Puppet
#     environment to manage several kickstack installations, you will
#     need to set these to distinguish the kickstack installations from
#     each other.
#   fact_filename - The name of the file (relative to facter/facts.d)
#     where kickstack stores its custom facts.
class kickstack ( 
  $fact_prefix   = $kickstack::params::fact_prefix,
  $fact_filename = $kickstack::params::fact_filename,
  $name_resolution = $kickstack::params::name_resolution,
  $verbose       = $kickstack::params::verbose,
  $debug         = $kickstack::params::debug,
  $database      = $kickstack::params::database,
  $rpc           = $kickstack::params::rpc,
  $rabbit_userid = $kickstack::params::rabbit_userid,
  $rabbit_virtual_host = $kickstack::params::rabbit_virtual_host,
  $qpid_username = $kickstack::params::qpid_username,
  $qpid_realm    = $kickstack::params::qpid_realm,
  $keystone_region = $kickstack::params::keystone_region,
  $keystone_public_suffix = $kickstack::params::keystone_public_suffix,
  $keystone_admin_suffix = $kickstack::params::keystone_admin_suffix,
  $keystone_admin_tenant = $kickstack::params::keystone_admin_tenant,
  $keystone_service_tenant = $kickstack::params::keystone_service_tenant,
  $keystone_admin_email = $kickstack::params::keystone_admin_email,
  $keystone_admin_password = $kickstack::params::keystone_admin_password,
  $cinder_backend = $kickstack::params::cinder_backend,
  $cinder_lvm_pv = $kickstack::params::cinder_lvm_pv,
  $cinder_lvm_vg = $kickstack::params::cinder_lvm_vg,
  $cinder_rbd_pool = $kickstack::params::cinder_rbd_pool,
  $cinder_rbd_user = $kickstack::params::cinder_rbd_user,
  $quantum_network_type = $kickstack::params::quantum_network_type,
  $quantum_plugin = $kickstack::params::quantum_plugin,
  $quantum_tenant_network_type = $kickstack::params::quantum_tenant_network_type,
  $quantum_network_vlan_ranges = $kickstack::params::quantum_network_vlan_ranges,
  $quantum_tunnel_id_ranges = $kickstack::params::quantum_tunnel_id_ranges,
  $nic_management = $kickstack::params::nic_management,
  $nic_data = $kickstack::params::nic_data,
  $nic_external = $kickstack::params::nic_external,
  $quantum_router_id = $kickstack::params::quantum_router_id,
  $quantum_gateway_external_network_id = $kickstack::params::quantum_gateway_external_network_id,
  $nova_compute_driver = $kickstack::params::nova_compute_driver, 
  $nova_compute_libvirt_type = $kickstack::params::nova_compute_libvirt_type,
  $xenapi_connection_url = $kickstack::params::xenapi_connection_url,
  $xenapi_connection_username = $kickstack::params::xenapi_connection_username,
  $xenapi_connection_password = $kickstack::params::xenapi_connection_password
) inherits kickstack::params {

  include exportfact
  include openstack::repo
  include kickstack::nameresolution
} 
