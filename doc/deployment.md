# How do I enable nodes for Kickstack?

You have several options:

- Using straightforward text-based Puppet configuration, using
  configuration files like `site.pp` and `nodes.pp`.
- Through a user interface that operates as a Puppet External Node
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

**Eeeek! Global variables? Really?** Relax. All Kickstack classes
inherit from a common base class, [`kickstack`](../manifests/init.pp),
which is a perfectly normal parameterized class. It is just that the
default values of the parameters of that class can be set with global
variables,
[falling back to reasonable defaults if the global variable is undefined](../manifests/params.pp). That
enables Kickstack to just `include` all of its classes, making their
use very simple, while still retaining the ability to configure
everything to your needs. If you don't like the global variables
approach, that's perfectly fine, you can still use Kickstack's classes
directly and set the parameters within your class declarations.

## Using Kickstack without an ENC

If you _do not_ run an ENC, then your Kickstack configuration goes
into standard Puppet manifests like `site.pp` and `nodes.pp`. A
Kickstack-enabled small OpenStack cloud with a handful of nodes might
look like this:

```puppet
node alice {
  include kickstack::node::infrastructure
  include kickstack::node::auth
  include kickstack::node::controller
  include kickstack::node::api
  include kickstack::node::storage
  include kickstack::node::dashboard
}

node bob {
  include kickstack::node::network
}

node default {
  include kickstack::node::compute
}
```

In this configuration, your node `alice` is your controller and API
node that also hosts your database, AMQP server and dashboard, `bob`
is your network node, and all other nodes are compute nodes.

Modifying your configuration is achieved through the use of global
variables prefixed with `kickstack_`. For example, you might want to
use Apache Qpid instead of the default RabbitMQ as your AMQP server:

```puppet

kickstack_rpc = 'qpid'

node alice {
  include kickstack::node::infrastructure
  include kickstack::node::auth
  # ... continued as above
```

Note that this approach is not very scalable and perhaps not the most
user-friendly, but it does give you the opportunity to keep all of
your Kickstack-related configuration in a single set of (hopefully
version-controlled) plain text files.

## Using Kickstack with an existing ENC

If your Puppet configuration includes an External Node Classifier
(ENC), then that ENC will give you the opportunity of defining
classes, assigning them to nodes, and also setting parameters (on a
per-node or per-group level).

For example, Puppet Dashboard enables you to create classes (matching
the classes defined in your Puppet module configuration) and set
parameters (passed into your configuration as global variables). You
may want to pre-populate your Puppet dashboard database with classes
and a `kickstack` group before adding nodes:

```sql
INSERT INTO node_classes (name, created_at, updated_at)
  VALUES (
    ('kickstack::node::infrastructure',NOW(),NOW()),
    ('kickstack::node::auth',NOW(),NOW()),
    ('kickstack::node::api',NOW(),NOW()),
    ('kickstack::node::controller',NOW(),NOW()),
    ('kickstack::node::storage',NOW(),NOW()),
    ('kickstack::node::dashboard',NOW(),NOW()),
    ('kickstack::node::network',NOW(),NOW()),
    ('kickstack::node::compute',NOW(),NOW())
  );
INSERT INTO node_groups (name, created_at, updated_at)
  VALUES (
    ('kickstack',NOW(),NOW())
  );
```

Then, you can assign classes to nodes from the Puppet Dashboard, and
also add them to the `kickstack` group. Then, you set your parameters
for the `kickstack` group, and all the member nodes will automatically
inherit them.

## Using Kickstack with your own ENC

Writing a Puppet ENC is beyond the scope of this README, please refer
to the
[Puppet documentation](http://docs.puppetlabs.com/guides/external_nodes.html)
for details.

If you already have a self-written ENC, however, all you need to do to
make Kickstack work is to have it include the appropriate
`kickstack::node::` classes in the YAML output for your nodes, and set
the `kickstack_` variables for them.
