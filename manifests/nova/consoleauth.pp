class kickstack::nova::consoleauth inherits kickstack {

  include kickstack::nova::config

  kickstack::nova::service { 'consoleauth': }

}
