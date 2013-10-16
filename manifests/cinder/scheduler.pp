class kickstack::cinder::scheduler inherits kickstack {

  include kickstack::cinder::config

  class { '::cinder::scheduler': 
    scheduler_driver => 'cinder.scheduler.simple.SimpleScheduler',
    package_ensure => $::kickstack::package_version,
  }
}
