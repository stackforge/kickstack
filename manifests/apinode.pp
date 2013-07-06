class kickstack::apinode inherits kickstack {
  include kickstack::api::keystone
  include kickstack::endpoints::keystone
}
