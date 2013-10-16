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
  $fact_category = $kickstack::params::fact_category,
  $release = $kickstack::params::release,
  $package_version = $kickstack::params::package_version,
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
  $cinder_backend = $kickstack::params::cinder_backend,
  $cinder_lvm_pv = $kickstack::params::cinder_lvm_pv,
  $cinder_lvm_vg = $kickstack::params::cinder_lvm_vg,
  $cinder_rbd_pool = $kickstack::params::cinder_rbd_pool,
  $cinder_rbd_user = $kickstack::params::cinder_rbd_user,
  $neutron_network_type = $kickstack::params::neutron_network_type,
  $neutron_plugin = $kickstack::params::neutron_plugin,
  $neutron_physnet = $kickstack::params::neutron_physnet,
  $neutron_tenant_network_type = $kickstack::params::neutron_tenant_network_type,
  $neutron_network_vlan_ranges = $kickstack::params::neutron_network_vlan_ranges,
  $neutron_tunnel_id_ranges = $kickstack::params::neutron_tunnel_id_ranges,
  $neutron_integration_bridge = $kickstack::params::neutron_integration_bridge,
  $neutron_tunnel_bridge = $kickstack::params::neutron_tunnel_bridge,
  $neutron_external_bridge = $kickstack::params::neutron_external_bridge,
  $nic_management = $kickstack::params::nic_management,
  $nic_data = $kickstack::params::nic_data,
  $nic_external = $kickstack::params::nic_external,
  $neutron_router_id = $kickstack::params::neutron_router_id,
  $neutron_gateway_external_network_id = $kickstack::params::neutron_gateway_external_network_id,
  $nova_compute_driver = $kickstack::params::nova_compute_driver,
  $nova_compute_libvirt_type = $kickstack::params::nova_compute_libvirt_type,
  $xenapi_connection_url = $kickstack::params::xenapi_connection_url,
  $xenapi_connection_username = $kickstack::params::xenapi_connection_username,
  $xenapi_connection_password = $kickstack::params::xenapi_connection_password,
  $horizon_allow_any_hostname = $kickstack::params::horizon_allow_any_hostname,
  $heat_apis = $kickstack::params::heat_apis,
) inherits kickstack::params {

  include ::exportfact
  include kickstack::repo
  include kickstack::nameresolution

  ::exportfact::import { $fact_category: }
}
