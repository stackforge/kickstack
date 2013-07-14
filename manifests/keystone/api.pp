class kickstack::keystone::api inherits kickstack {
  # Grab the Keystone admin token from a kickstack fact and configure
  # Keystone accordingly. If no fact has been set, generate a password.
  $admin_token = pick(getvar("${fact_prefix}keystone_admin_token"),pwgen())

  $sql_conn = getvar("${fact_prefix}keystone_sql_connection")

  class { '::keystone':
    package_ensure => 'latest',
    verbose        => $kickstack::verbose,
    debug          => $kickstack::debug,
    catalog_type   => 'sql',
    admin_token    => $admin_token,
    sql_connection => $sql_conn,
  }

  # Installs the service user endpoint.
  class { '::keystone::endpoint':
    public_address   => "${hostname}${keystone_public_suffix}",
    admin_address    => "${hostname}${keystone_admin_suffix}",
    internal_address => $hostname,
    region           => $keystone_region,
    require      => Class['::keystone']
  }

  kickstack::exportfact::export { "keystone_admin_token":
    value => "${admin_token}",
    tag => "keystone",
    require => Class['::keystone']
  }

  kickstack::exportfact::export { "keystone_internal_address":
    value => "${hostname}",
    tag => "keystone",
    require => Class['::keystone::endpoint']
  }

  # Adds the admin credential to keystone.
  class { '::keystone::roles::admin':
    email        => $kickstack::keystone_admin_email,
    password     => $kickstack::keystone_admin_password,
    admin_tenant => $kickstack::keystone_admin_tenant,
    service_tenant => $kickstack::keystone_service_tenant,
    require      => Class['::keystone::endpoint']
  }
}
