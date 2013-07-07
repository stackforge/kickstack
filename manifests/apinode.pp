class kickstack::apinode inherits kickstack {
  include kickstack::keystone::api
  include kickstack::endpoints::keystone

  kickstack::endpoints::service { [ "glance"]: }
}
