# What do I need to run Kickstack?

## Puppet prerequisites

First, you obviously need a Puppet master, running Puppet 3 or
later.

There is one non-default configuration option that you have to enable
for Kickstack to function, which is support for Exported
Resources. Please see
[the Puppet documentation on Exported Resources](http://docs.puppetlabs.com/puppet/2.7/reference/lang_exported.html)
for details.

Just as obviously, your OpenStack nodes need to be configured as
Puppet agents, also running Puppet 3 or later, properly authenticated
to the master and able to run `puppet agent`.

## Networking prerequisites

Kickstack requires that your cloud infrastructure has access to 3
different networks:

* The **management network,** which your cloud nodes use for access to
  the database, RPC service, and OpenStack APIs.
* The **data network,** which run the internal, virtual networks
  managed by OpenStack Networking.
* The **external network**, which connects your cloud to the outside
  world.

Kickstack by default assumes that on your nodes,

* the management network is connected to **eth0**,
* the data network is connected to **eth1**,
* the external network is connected to **eth2**.

If you configuration does not match that assumption, you can override
the defaults by setting the `kickstack_nic_management`,
`kickstack_nic_data` and `kickstack_nic_external` parameters,
respectively.

Kickstack will properly read these interfaces' IP addresses from your
nodes' network configuration, but it will not touch that network
configuration itself.
