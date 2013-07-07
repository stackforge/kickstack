class kickstack::keystone::endpoint inherits kickstack {
  # Grab the Keystone admin token from a kickstack fact and configure
  # Keystone accordingly. If no fact has been set, generate a password.
  $admin_token = pick(getvar("${fact_prefix}keystone_admin_token"),pwgen())

  # Installs the service user endpoint.
  class { '::keystone::endpoint':
    public_address   => "${hostname}${keystone_public_suffix}",
    admin_address    => "${hostname}${keystone_admin_suffix}",
    internal_address => $hostname,
    region           => $keystone_region,
    require      => Class['::keystone']
  }

  kickstack::exportfact::export { "keystone_internal_address":
    value => "${hostname}",
    tag => "keystone",
    require => Class['::keystone::endpoint']
  }

}
