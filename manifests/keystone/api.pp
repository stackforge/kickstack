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

  kickstack::exportfact::export { "keystone_admin_token":
    value => "${admin_token}",
    tag => "keystone",
    require => Class['::keystone']
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
