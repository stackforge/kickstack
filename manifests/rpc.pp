class kickstack::rpc inherits kickstack {
  case "$rpc" {
    'rabbitmq': {
      Class['nova::rabbitmq'] -> Exportfact::Export<| tag == 'rabbit' |>

      class { 'nova::rabbitmq': }

      kickstack::exportfact::export { "rabbit_host":
        value => "$hostname",
        tag => "rabbit"
      }

    }
    'qpid': {
      Class['nova::qpid'] -> Exportfact::Export<| tag == 'qpid' |>

      class { 'nova::qpid': }

      kickstack::exportfact::export { "qpid_hostname":
        value => "$hostname",
        tag => "qpid"
      }
    }
    default: {
      warn("Unsupported RPC server type: ${rpc_server}")
    }
  }
}
