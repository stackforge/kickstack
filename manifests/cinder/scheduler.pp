class kickstack::cinder::scheduler {

  include kickstack::cinder::config

  class { '::cinder::scheduler': 
    scheduler_driver => 'cinder.scheduler.simple.SimpleScheduler',
  }
}
