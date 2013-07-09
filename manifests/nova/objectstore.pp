class kickstack::nova::objectstore inherits kickstack {

  include kickstack::nova::config

  kickstack::nova::service { 'objectstore': }

}
