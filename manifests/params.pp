class kickstack::params {
  $variable_prefix = "kickstack_"

  # The fact prefix to be used for exportfact:
  # * default "kickstack_"
  # * override by setting "kickstack_fact_prefix"
  $fact_prefix = pick(getvar("::${variable_prefix}fact_prefix"), 'kickstack_')

  # The fact category to be used for exportfact, also sets
  # the filename in /etc/facter.d (<category>.txt):
  # * default "kickstack"
  # * override by setting "kickstack_fact_category"
  $fact_category = pick(getvar("::${variable_prefix}fact_category"), "kickstack")

  # The database backend type:
  # * default "mysql"
  # * override by setting "kickstack_database"
  $database = pick(getvar("::${variable_prefix}database"), 'mysql')

  # The mysql "root" user's password
  # (ignored unless kickstack_database=='mysql')
  # * default "kickstack"
  # * override by setting "kickstack_mysql_root_password"
  $mysql_root_password = pick(getvar("::${variable_prefix}mysql_root_password"), 'kickstack')

  # The "postgres" user's password
  # (ignored unless kickstack_database=='postgresql')
  # * default "kickstack"
  # * override by setting "kickstack_postgres_password"
  $postgres_password = pick(getvar("::${variable_prefix}postgres_password"), 'kickstack')

  # The RPC server type:
  # * default "rabbitmq"
  # * override by setting "kickstack_amqp"
  $rpc = pick(getvar("::${variable_prefix}rpc"), 'rabbitmq')

  # RabbitMQ user name:
  $rabbit_user = getvar("::${variable_prefix}rabbit_user")

  # RabbitMQ password:
  $rabbit_password = getvar("::${variable_prefix}rabbit_password")

  # RabbitMQ virtual host
  $rabbit_virtual_host = getvar("::${variable_prefix}rabbit_virtual_host")

  # Qpid user name:
  $qpid_username = getvar("::${variable_prefix}qpid_username")

  # Qpid password:
  $qpid_password = getvar("::${variable_prefix}qpid_password")

}
