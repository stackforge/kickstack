# Kickstack: Pure-Puppet Rapid System Deployment for OpenStack

## What is Kickstack?

Kickstack is a set of relatively thin wrappers around the
[Puppet](http://puppetlabs.com/puppet/what-is-puppet/) modules for
[OpenStack](http://www.openstack.org). These modules are hosted at
[StackForge](http://ci.openstack.org/stackforge.html) and are also
available through the [Puppet Forge](http://forge.puppetlabs.com).

Kickstack adds a thin, pure-Puppet wrapper layer on top of these
modules that enables you to deploy an OpenStack cloud in minutes.

## What does Kickstack do?

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

## What do I need to run Kickstack?

First, you obviously need a Puppet master. There is one non-default
configuration option that you have to enable for Kickstack to
function, which is support for Exported Resources. Please see
[the Puppet documentation on Exported Resources](http://docs.puppetlabs.com/puppet/2.7/reference/lang_exported.html)
for details. Just as obviously, your OpenStack nodes need to be
configured as Puppet agents, properly authenticated to the master and
able to run `puppet agent`.

## How do I enable nodes for Kickstack?

You have several options:

- Using straightforward text-based Puppet configuration, using
  configuration files like `site.pp` and `nodes.pp`.
- Trough a user interface that operates as a Puppet External Node
  Classifier (ENC) and can assign nodes to classes. Examples for such
  ENCs are the
  [Puppet Dashboard](https://puppetlabs.com/puppet/related-projects/dashboard/),
  the
  [Puppet Enterprise](http://docs.puppetlabs.com/pe/3.0/index.html)
  Console, and [The Foreman](http://theforeman.org/).
- Writing your own ENC.

Regardless of which option you choose, you enable OpenStack node roles
by assigning nodes to one or several of the Kickstack
classes. Likewise, you can tweak your configuration by setting any of
the global variables that Kickstack understands (which, by default,
are all prefixed with `kickstack_` so they do not collide with other
global variables that are already in your configuration).
