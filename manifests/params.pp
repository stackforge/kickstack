class kickstack::params {
  $variable_prefix = 'kickstack_'

  # The fact prefix to be used for exportfact:
  # * default "kickstack_"
  # * override by setting "kickstack_fact_prefix"
  $fact_prefix = pick(getvar("::${variable_prefix}fact_prefix"),
                 $variable_prefix)

  # The fact category to be used for exportfact, also sets
  # the filename in /etc/facter.d (<category>.txt):
  # * default "kickstack"
  # * override by setting "kickstack_fact_category"
  $fact_category = pick(getvar("::${variable_prefix}fact_category"),
                        'kickstack')

  # Version number of OpenStack *server* packages.
  #
  # * default 'installed', meaning use whatever version is available
  #   at the time of installation, and don't upgrade
  # * set to 'latest' to use whichever is the latest version available
  #   in the package repos, upgrading existing packages if necessary
  # * set to a specific version number if you want to lock your system
  #   to a particular build
  #
  # Note: if you set this to a specific version, then this assumes
  # that your distro synchronizes version numbers across OpenStack
  # server packages.
  $package_version = pick(getvar("::${variable_prefix}package_version"),
                         'installed')

  # The OpenStack release to install
  # * default 'havana'
  # * override by using a different OpenStack release name
  #   (all lowercase)
  # This is for new installations only; don't expect this to magically
  # support rolling releases.
  $release = pick(getvar("::${variable_prefix}release"),
                         'havana')

  # The strategy to use so machines can make their hostnames known to
  # each other.
  # * default "hosts" -- manage /etc/hosts
  $name_resolution = pick(getvar("::${variable_prefix}name_resolution"),
                          'hosts')

  # Enables verbose logging globally
  $verbose = str2bool(pick(getvar("::${variable_prefix}verbose"),
                           'false'))

  # Enables debug logging globally
  $debug = str2bool(pick(getvar("::${variable_prefix}debug"),
                         'false'))

  # The database backend type:
  # * default "mysql"
  # * override by setting "kickstack_database"
  $database = pick(getvar("::${variable_prefix}database"),
                          'mysql')

  # The mysql "root" user's password
  # (ignored unless kickstack_database=='mysql')
  # * default "kickstack"
  # * override by setting "kickstack_mysql_root_password"
  $mysql_root_password = pick(getvar("::${variable_prefix}mysql_root_password"),
                              'kickstack')

  # The "postgres" user's password
  # (ignored unless kickstack_database=='postgresql')
  # * default "kickstack"
  # * override by setting "kickstack_postgres_password"
  $postgres_password = pick(getvar("::${variable_prefix}postgres_password"),
                            'kickstack')

  # The RPC server type:
  # * default "rabbitmq"
  # * override by setting "kickstack_amqp"
  $rpc = pick(getvar("::${variable_prefix}rpc"),
              'rabbitmq')

  # RabbitMQ user name:
  $rabbit_userid = pick(getvar("::${variable_prefix}rabbit_userid"),
                        'kickstack')

  # RabbitMQ virtual host
  $rabbit_virtual_host = pick(getvar("::${variable_prefix}rabbit_virtual_host"),
                              '/')

  # Qpid user name:
  $qpid_username = pick(getvar("::${variable_prefix}qpid_username"),
                        'kickstack')

  # Qpid realm:
  $qpid_realm = getvar("::${variable_prefix}qpid_realm")

  # The Keystone region to manage
  $keystone_region = pick(getvar("::${variable_prefix}keystone_region"),
                          'kickstack')

  # The suffix to append to the keystone hostname for publishing
  # the public service endpoint (default: none)
  $keystone_public_suffix = getvar("::${variable_prefix}keystone_public_suffix")

  # The suffix to append to the keystone hostname for publishing
  # the admin service endpoint (default: none)
  $keystone_admin_suffix = getvar("::${variable_prefix}keystone_admin_suffix")

  # The tenant set up so that individual OpenStack services can
  # authenticate with Keystone
  $keystone_service_tenant = pick(getvar("::${variable_prefix}keystone_service_tenant"),
                                  'services')

  # The special tenant set up for administrative purposes
  $keystone_admin_tenant = pick(getvar("::${variable_prefix}keystone_admin_tenant"),
                                'openstack')

  # The email address set for the admin user
  $keystone_admin_email = pick(getvar("::${variable_prefix}keystone_admin_email"),
                               "admin@${hostname}")

  # The backend to use with Cinder. Supported: iscsi (default)
  $cinder_backend = pick(getvar("::${variable_prefix}cinder_backend"),
                         'iscsi')

  # The device to create the LVM physical volume on. Ignored unless
  # $cinder_backend==iscsi.
  $cinder_lvm_pv = pick(getvar("::${variable_prefix}cinder_lvm_pv"),
                        '/dev/disk/by-partlabel/cinder-volumes')

  # The LVM volume group name to use for volumes. Ignored unless
  # $cinder_backend==iscsi.
  $cinder_lvm_vg = pick(getvar("::${variable_prefix}cinder_lvm_vg"),
                        'cinder-volumes')

  # The RADOS pool to use for volumes. Ignored unless $cinder_backend==rbd.
  $cinder_rbd_pool = pick(getvar("::${variable_prefix}cinder_rbd_pool"),
                          'cinder-volumes')

  # The RADOS user to use for volumes. Ignored unless $cinder_backend==rbd.
  $cinder_rbd_user = pick(getvar("::${variable_prefix}cinder_rbd_pool"),
                          'cinder')

  # The network type to configure for Neutron.  See
  # http://docs.openstack.org/grizzly/openstack-network/admin/content/use_cases.html
  # Supported:
  # single-flat
  # provider-router
  # per-tenant-router (default)
  $neutron_network_type = pick(getvar("::${variable_prefix}neutron_network_type"),
                               'per-tenant-router')

  # The plugin to use with Neutron.
  # Supported:
  # linuxbridge
  # ovs (default)
  $neutron_plugin = pick(getvar("::${variable_prefix}neutron_plugin"),
                                'ovs')

  # The tenant network type to use with the Neutron ovs and linuxbridge plugins
  # Supported: gre (default), flat, vlan
  $neutron_tenant_network_type = pick(getvar("::${variable_prefix}neutron_tenant_network_type"),
                                      'gre')

  # The Neutron physical network name to define (ignored if
  # tenant_network_type=='gre'
  $neutron_physnet = pick(getvar("::${variable_prefix}neutron_physnet"),
                          'physnet1')

  # The network VLAN ranges to use with the Neutron ovs and
  # linuxbridge plugins (ignored unless neutron_tenant_network_type ==
  # 'vlan')
  $neutron_network_vlan_ranges = pick(getvar("::${variable_prefix}neutron_network_vlan_ranges"),
                                      '2000:3999')

  # The tunnel ID ranges to use with the Neutron ovs plugin, when in gre mode
  # (ignored unless neutron_tenant_network_type == 'gre')
  $neutron_tunnel_id_ranges = pick(getvar("::${variable_prefix}neutron_tunnel_id_ranges"),
                                   '1:1000')

  # The Neutron integration bridge
  # Default: br-int (normally doesn't need to be changed)
  $neutron_integration_bridge = pick(getvar("::${variable_prefix}neutron_integration_bridge"),
                                     'br-int')

  # The Neutron tunnel bridge (irrelevant unless
  # $neutron_tenant_network_type=='gre')
  # Default: br-tun (normally doesn't need to be changed)
  $neutron_tunnel_bridge = pick(getvar("::${variable_prefix}neutron_tunnel_bridge"),
                                       'br-tun')

  # The Neutron external bridge
  # Default: br-ex (normally doesn't need to be changed)
  $neutron_external_bridge = pick(getvar("::${variable_prefix}neutron_external_bridge"),
                                  'br-ex')

  # The interface over which to run your nodes' management network traffic.
  # Normally, this would be your primary network interface.
  $nic_management = pick(getvar("::${variable_prefix}nic_management"),
                         'eth0')

  # The interface over which to run your tenant guest traffic.
  # This would be a secondary interface, present on your network node
  # and compute nodes.
  $nic_data = pick(getvar("::${variable_prefix}nic_data"),
                   'eth1')

  # The interface you use to connect to the public network.  This
  # interface would only be present on your network nodes, and
  # possibly also on your API nodes if you wish to expose the API
  # services publicly.
  $nic_external = pick(getvar("::${variable_prefix}nic_external"),
                       'eth2')

  # The Neutron router uuid (irrelevant unless
  # $neutron_network_type=='provider_router')
  $neutron_router_id = getvar("::${variable_prefix}neutron_router_id")

  # The Neutron external network uuid (irrelevant unless
  # $neutron_network_type=='provider_router')
  $neutron_gateway_external_network_id = getvar("::${variable_prefix}gateway_external_network_id")

  # The nova-compute backend driver.
  # Supported: libvirt (default), xenserver
  $nova_compute_driver = pick(getvar("::${variable_prefix}nova_compute_driver"),
                              'libvirt')

  # The hypervisor to use with libvirt (ignored unless
  # nova_compute_driver==libvirt)
  # Supported: kvm (default), qemu
  $nova_compute_libvirt_type = pick(getvar("::${variable_prefix}nova_compute_libvirt_type"),
                                    'kvm')

  # The XenAPI connection URL (ignored unless nova_compute_driver==xenserver)
  $xenapi_connection_url = getvar("::${variable_prefix}xenapi_connection_url")

  # The XenAPI user name (ignored unless nova_compute_driver==xenserver)
  $xenapi_connection_username = getvar("::${variable_prefix}xenapi_connection_username")

  # The XenAPI password (ignored unless nova_compute_driver==xenserver)
  $xenapi_connection_password = getvar("::${variable_prefix}xenapi_connection_password")

  # Allow access to Horizon using any host name?
  # Default is false, meaning allow Horizon access only through the
  # FQDN of the dashboard host.
  # Set to true if you want to access by IP address, through an SSH
  # tunnel, etc.
  $horizon_allow_any_hostname = str2bool(pick(getvar("::${variable_prefix}horizon_allow_any_hostname"),'false'))

  # Enabled Heat APIs (comma-separated list of exposed APIs)
  # Can be any combination of 'heat', 'cfn', and 'cloudwatch'
  # Default is just 'heat' (the native Heat API)
  $heat_apis = pick(getvar("::${variable_prefix}heat_apis"),'heat')
}
