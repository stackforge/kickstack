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
