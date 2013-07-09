class kickstack::nova::scheduler inherits kickstack {

  include kickstack::nova::config

  kickstack::nova::service { 'scheduler': }

}
