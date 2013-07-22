# What do I need to run Kickstack?

First, you obviously need a Puppet master. There is one non-default
configuration option that you have to enable for Kickstack to
function, which is support for Exported Resources. Please see
[the Puppet documentation on Exported Resources](http://docs.puppetlabs.com/puppet/2.7/reference/lang_exported.html)
for details. Just as obviously, your OpenStack nodes need to be
configured as Puppet agents, properly authenticated to the master and
able to run `puppet agent`.
