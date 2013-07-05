define kickstack::exportfact::export (
  $value
) {

  ::exportfact::export { "${kickstack::fact_prefix}${name}":
    value => $value,
    category => "$kickstack::fact_category"
  }

}
