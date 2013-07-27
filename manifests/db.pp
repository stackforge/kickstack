define kickstack::db {

  include pwgen

  $fact_prefix = $::kickstack::fact_prefix
  $database = $::kickstack::database

  $servicename = $name
  $username = $name

  # Retrieve the currently set password for the service from its
  # kickstack_*_sql_connection fact.
  # If it's unset, generate one and subsequently export it.
  $sql_connection = getvar("${fact_prefix}${servicename}_sql_connection")
  $sql_password = $sql_connection ? {
                  undef => pwgen(),
                  default => pick(regsubst(getvar("${fact_prefix}${servicename}_sql_connection"),
                    ".*://${username}:(.*)@.*/${servicename}",
                    '\1'),
                    pwgen())
                  }

  # Export facts about the database only after configuring the database
  Class["${servicename}::db::${database}"] -> Exportfact::Export<| tag == "$database" |>

  # Configure the service database (classes look like nova::db::mysql or
  # glance::db:postgresql, for example).
  # If running on mysql, set the "allowed_hosts" parameter to % so we
  # can connect to the database from anywhere.
  case "${database}" {
    'mysql': {
      class { "${servicename}::db::mysql":
        user => $username,
        password => $sql_password,
        charset => 'utf8',
        allowed_hosts => '%',
        notify => Kickstack::Exportfact::Export["${name}_sql_connection"]
      }
    }
    default: {
      class { "${name}::db::${database}":
        password => $sql_password
      }
    }
  }

  # Export the MySQL connection string for the service
  kickstack::exportfact::export { "${name}_sql_connection":
    value => "${database}://${name}:${sql_password}@${hostname}/${name}",
    tag => "$database"
  }

}
