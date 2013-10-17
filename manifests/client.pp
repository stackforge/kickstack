define kickstack::client {

  $servicename = $name
  $classname = "::${servicename}::client"

  class { $classname: }

}
