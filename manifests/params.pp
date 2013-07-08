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

  # Enables verbose logging globally 
  $verbose = str2bool(pick(getvar("::${variable_prefix}verbose"), 'false'))

  # Enables debug logging globally
  $debug = str2bool(pick(getvar("::${variable_prefix}debug"), 'false'))

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
  $rabbit_userid = pick(getvar("::${variable_prefix}rabbit_userid"),'guest')

  # RabbitMQ virtual host
  $rabbit_virtual_host = pick(getvar("::${variable_prefix}rabbit_virtual_host"),'/')

  # Qpid user name:
  $qpid_username = pick(getvar("::${variable_prefix}qpid_username"),'guest')

  # Qpid realm:
  $qpid_realm = getvar("::${variable_prefix}qpid_realm")

  # The Keystone region to manage
  $keystone_region = pick(getvar("::${variable_prefix}keystone_region"), 'kickstack')

  # The suffix to append to the keystone hostname for publishing
  # the public service endpoint
  $keystone_public_suffix = getvar("::${variable_prefix}keystone_public_suffix")

  # The suffix to append to the keystone hostname for publishing
  # the admin service endpoint
  $keystone_admin_suffix = getvar("::${variable_prefix}keystone_admin_suffix")

  # The tenant set up so that individual OpenStack services can
  # authenticate with Keystone
  $keystone_service_tenant = pick(getvar("::${variable_prefix}keystone_service_tenant"),"services")

  # The special tenant set up for administrative purposes
  $keystone_admin_tenant = getvar("::${variable_prefix}keystone_admin_tenant")

  # The email address set for the admin user
  $keystone_admin_email = pick(getvar("::${variable_prefix}keystone_admin_email"),"admin@${hostname}")

  # The initial password to set for the admin user
  $keystone_admin_password = pick(getvar("::${variable_prefix}keystone_admin_password"),"kickstack")

  # The backend to use with Cinder. Supported: iscsi (default), rbd
  $cinder_backend = pick(getvar("::${variable_prefix}cinder_backend"),"iscsi")

  # The device to create the LVM physical volume on. Ignored unless $cinder_backend==iscsi.
  $cinder_lvm_pv = pick(getvar("::${variable_prefix}cinder_lvm_pv"),"/dev/disk/by-partlabel/cinder-volumes")

  # The LVM volume group name to use for volumes. Ignored unless $cinder_backend==iscsi.
  $cinder_lvm_vg = pick(getvar("::${variable_prefix}cinder_lvm_vg"),"cinder-volumes")

  # The RADOS pool to use for volumes. Ignored unless $cinder_backend==rbd.
  $cinder_rbd_pool = pick(getvar("::${variable_prefix}cinder_rbd_pool"),"cinder-volumes")

  # The RADOS user to use for volumes. Ignored unless $cinder_backend==rbd.
  $cinder_rbd_user = pick(getvar("::${variable_prefix}cinder_rbd_pool"),"cinder")
}
