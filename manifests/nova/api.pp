class kickstack::nova::api inherits kickstack {

  include kickstack::nova::config
  include pwgen

  # Grab the Keystone admin password from a kickstack fact and configure
  # Keystone accordingly. If no fact has been set, generate a password.
  $admin_password = pick(getvar("${fact_prefix}nova_keystone_password"),pwgen())
  $auth_host = getvar("${fact_prefix}keystone_internal_address")
  $neutron_secret = pick(getvar("${fact_prefix}neutron_metadata_shared_secret"),pwgen())

  # Stupid hack: Grizzly packages in Ubuntu Cloud Archive
  # require python-eventlet > 0.9, but the python-nova
  # package in UCA does not reflect this
  package { 'python-eventlet':
    ensure => latest
  }

  class { '::nova::api':
    enabled           => true,
    auth_strategy     => 'keystone',
    auth_host         => $auth_host,
    admin_tenant_name => $kickstack::keystone_service_tenant,
    admin_user        => 'nova',
    admin_password    => $admin_password,
    enabled_apis      => 'ec2,osapi_compute,metadata',
    neutron_metadata_proxy_shared_secret => $neutron_secret
  }

  kickstack::endpoint { 'nova':
    service_password => $admin_password,
    require           => Class['::nova::api']
  }

  # Export the metadata API IP address and shared secret, to be picked up
  # by the Neutron metadata proxy agent on the network node
  kickstack::exportfact::export { "nova_metadata_ip":
    value => getvar("ipaddress_${nic_management}"),
    tag => "nova",
    require => Class['::nova::api']
  }
  kickstack::exportfact::export { "neutron_metadata_shared_secret":
    value => $neutron_secret,
    tag => 'nova',
    require => Class['::nova::api']
  }
}
