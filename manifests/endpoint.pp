define kickstack::endpoint ( $service_password ) {

  include pwgen

  $servicename = $name
  $factname = "${servicename}_keystone_password"
  $classname = "${servicename}::keystone::auth"

  # Installs the service user endpoint.
  class { $classname:
    password => $service_password,
    public_address => "${hostname}${::kickstack::keystone_public_suffix}",
    admin_address => "${hostname}${::kickstack::keystone_admin_suffix}",
    internal_address => $hostname,
    region => $::kickstack::keystone_region,
    require => Class['::keystone'],
  }

  kickstack::exportfact::export { $factname:
    value => $service_password,
    tag => $servicename,
    require => Class[$classname]
  }

}
