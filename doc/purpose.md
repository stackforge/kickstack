# What does Kickstack do?

Kickstack operates on the assumption that in an OpenStack cluster
_nodes_ (physical servers) fulfill certain _roles._ These roles are

* _atomic,_ meaning that typically, the services belonging to a role
  are not split across several nodes; and
* _composable,_ meaning it is perfectly feasible for any node to have
  several roles at the same time.

Note that this, of course, includes the possibility of one node role
being deployed onto several nodes -- for the purpose of either
scalability or high availability.

In Kickstack, you simply assign roles to nodes, optionally set
parameters to modify your service configuration, and let Puppet do the
rest.

## High-level configuration

Kickstack places an emphasis on high-level configuration, rather than
forcing you to deal with little details. For example, switching your
entire infrastructure from one RPC server to another simply means
changing one configuration parameter, `kickstack_rpc`, from `rabbitmq`
to `qpid`. Then, Kickstack will not only install and configure that
service for you, but also reconfigure *all* your dependent services to
use the new RPC server type.

Likewise, Kickstack will auto-configure service passwords and make
them known to the services that need them. It will also inform
services of the network information and credentials they need to to
connect to other services, etc.

## Order of service deployment

In OpenStack, certain services must be deployed in a certain
order. For example, database and RPC server must come first, then we
can install Keystone for authentication. Once Keystone is set up, we
can add service endpoints, and so forth.

Kickstack enforces this order of service deployment across all the
nodes it manages. For example, while it is perfectly fine to designate
a node as a Keystone authentication node, the Puppet runs on that node
will essentially be empty until a configured Keystone database is
known to the system. Likewise, a compute node will just not install
until there is a Nova API service to manage it.

## Shared information between nodes

To share information between nodes, Kickstack makes use of the
`exportfact` module. Exportfact is a simple module that uses Puppet
Exported Resources to share Facts between nodes. These facts obviously
contain potentially sensitive information such as passwords which,
while they are transmitted securely *between* nodes (between the
Puppet agent and master), are stored unencrypted both on the Puppet
master and on the Puppet agent. Since this is no different from what
would normally be stored on an OpenStack node anyway -- in files that
are only readable by `root` and the respective service user, such as
`cinder` -- this adds no significant *additional* security exposure.
