class kickstack::api::keystone inherits kickstack {
  # Grab the Keystone admin token from a kickstack fact and configure
  # Keystone accordingly. If no fact has been set, generate a password.
  $admin_token = pick(getvar("${fact_prefix}keystone_admin_token"),pwgen())

  class { '::keystone':
    package_ensure => 'latest',
    verbose        => 'True',
    catalog_type   => 'sql',
    admin_token    => $admin_token,
    sql_connection => getvar("${fact_prefix}keystone_sql_connection"),
  }

  kickstack::exportfact::export { "keystone_admin_token":
    value => "${admin_token}",
    tag => "keystone",
    require => Class['::keystone']
  }

  # Adds the admin credential to keystone.
  class { '::keystone::roles::admin':
    email        => $keystone_admin_email,
    password     => $keystone_admin_password,
    admin_tenant => $keystone_admin_tenant,
    service_tenant => $keystone_service_tenant,
    require      => Class['::keystone::endpoint']
  }
}
