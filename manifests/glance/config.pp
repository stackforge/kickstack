class kickstack::glance::config inherits kickstack {
  class { '::glance': 
    package_ensure => $::kickstack::package_version,
  } 
}
