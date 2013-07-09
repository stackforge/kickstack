class kickstack::nova::cert inherits kickstack {

  include kickstack::nova::config

  kickstack::nova::service { 'cert': }

}
