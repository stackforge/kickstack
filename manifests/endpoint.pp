define kickstack::endpoint ( $service_password,
                             $servicename = $name,
                             $classname = 'auth',
                             $factname = "${name}_keystone_password" ) {

  $fullclassname = "${servicename}::keystone::${classname}"

  # Installs the service user endpoint.
  class { $fullclassname:
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
    require => Class[$fullclassname]
  }

}
