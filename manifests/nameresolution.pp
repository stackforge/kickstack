class kickstack::nameresolution inherits kickstack {

  case $::kickstack::name_resolution {
    'hosts': {

      @@host { "$hostname":
        ip => getvar("ipaddress_${::kickstack::nic_management}"),
        comment => "Managed by Puppet",
        tag => "hostname"
      }

      Host <<| tag == "hostname" |>> {  }
    }
  }
}

