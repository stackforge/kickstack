class kickstack::nameresolution inherits kickstack {

  case $::kickstack::name_resolution {
    'hosts': {

      @@host { "$hostname":
        ip => $ipaddress,
        comment => "Managed by Puppet",
        tag => "hostname"
      }

      Host <<| tag == "hostname" |>> {  }
    }
  }
}

