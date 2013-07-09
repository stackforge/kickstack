class kickstack::nova::vncproxy inherits kickstack {

  include kickstack::nova::config

  kickstack::nova::service { 'vncproxy': }

}
