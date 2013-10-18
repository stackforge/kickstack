class kickstack::cinder::volume inherits kickstack {

  include kickstack::cinder::config

  class { '::cinder::volume':
    package_ensure => $::kickstack::package_version,
  }

  case $::kickstack::cinder_backend {
    'iscsi': {
      $pv = "$::kickstack::cinder_lvm_pv"
      $vg = "$::kickstack::cinder_lvm_vg"
      physical_volume { "$pv":
        ensure => present
      }
      volume_group { "$vg":
        ensure => present,
        physical_volumes => "$pv",
        require => Physical_volume["$pv"]
      }
      class { '::cinder::volume::iscsi': 
        iscsi_ip_address => getvar("ipaddress_${nic_management}"),
        require => Volume_group["$vg"]
      }
    }
    'rbd': {
      $rbd_secret_uuid = getvar("${fact_prefix}rbd_secret_uuid")
      class { '::cinder::volume::rbd':
        rbd_pool => $cinder_rbd_pool,
        rbd_user => $cinder_rbd_user,
        rbd_secret_uuid => $rbd_secret_uuid
      }
    }
  }
}
