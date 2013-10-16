class kickstack::repo inherits kickstack {
  class { '::openstack::repo':
    release => $::kickstack::release
  }
}
