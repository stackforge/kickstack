class kickstack::glance::config inherits kickstack {
  class { '::glance': 
    package_ensure => 'latest',
  } 
}
