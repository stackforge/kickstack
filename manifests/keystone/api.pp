class kickstack::keystone::api inherits kickstack {
  include pwgen  

  $admin_token = pick(getvar("${fact_prefix}keystone_admin_token"),pwgen())
  $admin_password = pick(getvar("${fact_prefix}keystone_admin_password"),pwgen())
  $admin_tenant = $::kickstack::keystone_admin_tenant
  $sql_conn = getvar("${fact_prefix}keystone_sql_connection")

  class { '::keystone':
    package_ensure => $::kickstack::package_version,
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
    password     => $admin_password,
    admin_tenant => $admin_tenant,
    service_tenant => $kickstack::keystone_service_tenant,
    require      => Class['::keystone::endpoint']
  }

  file { '/root/openstackrc':
    owner => root,
    group => root,
    mode => '0640',
    content => template('kickstack/openstackrc.erb'),
    require => Class['::keystone::roles::admin']
  }

  kickstack::exportfact::export { "keystone_admin_password":
    value => $admin_password,
    tag => "keystone",
    require => Class['::keystone::roles::admin']
  }

}
