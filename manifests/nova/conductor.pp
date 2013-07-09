class kickstack::nova::conductor inherits kickstack {

  include kickstack::nova::config

  kickstack::nova::service { 'conductor': }

}
