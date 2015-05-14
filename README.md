# Important

Kickstack is now **retired**. It was originally conceived as a
simplified method of deploying OpenStack with a higher-level Puppet
abstraction than the then-available vendor deployment facilities
provided. During the OpenStack Icehouse and Juno releases, all major
OpenStack vendors released deployment facilities that render Kickstack
obsolete, and that is a good thing.

Some alternatives that you may want to try (note: this list was
written at the time of the OpenStack Juno release, and will not be
updated):

- Puppet based: Packstack/Quickstack (RDO), Staypuft (RHEL OSP), Fuel
  (Mirantis OpenStack)
- Non Puppet based: Juju (Ubuntu), Crowbar (SUSE Cloud)

This repository is kept around for reference purposes only.


# Kickstack: Kickstart your OpenStack

Kickstack is a
pure-[Puppet](http://puppetlabs.com/puppet/what-is-puppet/) rapid
deployment system for [OpenStack](http://www.openstack.org). It uses
Puppet modules hosted at
[StackForge](http://docs.openstack.org/infra/system-config/stackforge.html) that are also
available through the [Puppet Forge](http://forge.puppetlabs.com).

Kickstack adds a thin, pure-Puppet wrapper layer on top of these
modules that enables you to deploy an OpenStack cloud in minutes.

For more detailed information, see

* [What does Kickstack do?](doc/purpose.md)
* [What do I need to run Kickstack?](doc/prerequisites.md)
* [How do I enable nodes for Kickstack?](doc/deployment.md)
