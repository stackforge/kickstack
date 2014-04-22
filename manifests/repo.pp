class kickstack::repo inherits kickstack {
  class { '::openstack::resources::repo':
    release => $::kickstack::release
  }
}
