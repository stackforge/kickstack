class kickstack::rpc inherits kickstack {
  case "$rpc" {
    'rabbitmq': {
      Class['nova::rabbitmq'] -> Exportfact::Export<| tag == 'rabbit' |>

      $rabbit_password = pick(getvar("${::kickstack::fact_prefix}rabbit_password"),pwgen())

      class { 'nova::rabbitmq':
        userid => "$::kickstack::rabbit_userid",
        password => "$rabbit_password",
        virtual_host => "$::kickstack::rabbit_virtual_host"
      }

      kickstack::exportfact::export { "rabbit_host":
        value => "$hostname",
        tag => "rabbit"
      }

      kickstack::exportfact::export { "rabbit_password":
        value => "$rabbit_password",
        tag => "rabbit"
      }

    }
    'qpid': {
      Class['nova::qpid'] -> Exportfact::Export<| tag == 'qpid' |>

      $qpid_password = pick(getvar("${::kickstack::fact_prefix}qpid_password"),pwgen())

      class { 'nova::qpid':
        user => "$::kickstack_qpid_username",
        password => "$qpid_password",
        realm => "$::kickstack_qpid_realm"
      }

      kickstack::exportfact::export { "qpid_hostname":
        value => "$hostname",
        tag => "qpid"
      }

      kickstack::exportfact::export { "qpid_password":
        value => "$qpid_password",
        tag => "qpid"
      }
    }
    default: {
      warn("Unsupported RPC server type: ${rpc_server}")
    }
  }
}
