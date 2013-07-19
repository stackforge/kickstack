class kickstack::nova::vncproxy inherits kickstack {

  include kickstack::nova::config

  kickstack::nova::service { 'vncproxy': }

  unless getvar("${::kickstack::fact_prefix}vncproxy_host") {
    kickstack::exportfact::export { "vncproxy_host":
      value => "${hostname}",
      tag => "nova",
      require => Kickstack::Nova::Service["vncproxy"]
    }
  }
}
