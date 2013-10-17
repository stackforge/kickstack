class kickstack::heat::api inherits kickstack {

  include pwgen
  include ::kickstack::heat::config

  $apis = split($::kickstack::heat_apis,',')

  if 'heat' in $apis {
    $heat_admin_password = pick(getvar("${fact_prefix}heat_keystone_password"),pwgen())
    class { '::heat::api':
      enabled => true,
    }

    kickstack::endpoint { 'heat':
      service_password => $heat_admin_password,
      require => Class['::heat::api']
    }

    kickstack::exportfact::export { 'heat_metadata_server':
      value => $hostname,
      tag => 'heat',
      require => Class['::heat::api']
    }

  }

  if 'cfn' in $apis {
    $cfn_admin_password = pick(getvar("${fact_prefix}heat_cfn_keystone_password"),pwgen())

    class { '::heat::api_cfn':
      enabled => true,
    }

    kickstack::endpoint { 'heat_cfn':
      servicename => 'heat',
      classname => 'auth_cfn',
      factname => "heat_cfn_keystone_password",
      service_password => $cfn_admin_password,
      require => Class['::heat::api_cfn']
    }
  }

  if 'cloudwatch' in $apis {
    class { '::heat::api_cloudwatch':
      enabled => true,
    }

    kickstack::exportfact::export { 'heat_watch_server':
      value => $hostname,
      tag => 'heat',
      require => Class['::heat::api_cloudwatch']
    }

    # The puppet-heat module has no facility for setting up the
    # CloudWatch Keystone endpoint.
  }

}
