define kickstack::endpoints::service {

  include pwgen

  $servicename = $name
  $factname = "${servicename}_keystone_password"
  $classname = "${servicename}::keystone::auth"

  # Grab the service's keystone user password from a kickstack fact and configure
  # Keystone accordingly. If no fact has been set, generate a password.
  $service_password = pick(getvar("${::kickstack::fact_prefix}${factname}"),pwgen())

  # Installs the service user endpoint.
  class { "${classname}":
    password         => "$service_password",
    public_address   => "${hostname}${keystone_public_suffix}",
    admin_address    => "${hostname}${keystone_admin_suffix}",
    internal_address => "$hostname",
    region           => "$::kickstack::keystone_region",
    require          => Class['::keystone'],
  }

  kickstack::exportfact::export { "${factname}":
    value => "${service_password}",
    tag => "${servicename}",
    require => Class["${classname}"]
  }

}
