# Talon
A Vagrant + Puppet Highly Portable Configured Development Box

## Todo
- Write summary and update this readme file
- figure out a way to auto checkout, fetch and update all projects on build (maybe this can be a list of things in hiera... https://docs.puppetlabs.com/hiera/1/complete_example.html)
- similarly, have a way to install packages I like
- set up a basic postgres install (http://jes.al/2014/04/setup-dev-environment-using-vagrant-puppet-part-ii/)
- figure out the ssh agent so i don't have to enter the key password all the time
- mouse support
- setup and configure vim:
  - https://forge.puppetlabs.com/saz/vim
  - http://statico.github.io/vim.html
  - http://nvie.com/posts/how-i-boosted-my-vim/
	- syntastic
	- you complete me		
	- knwang/dotfiles

## Known Issues
- April 8, 2015: bundler is not available after entering an rvm controller project, requiring manually selecting the ruby version with rvm, detailed here: http://stackoverflow.com/questions/29520563/why-does-bundler-disapear-after-entering-project-directory-with-puppet-installed

## Installation Steps
- Download this source
- vagrant up
- vagrant ssh
- install the vim plugins
- load the correct fonts `/fonts` to your local system

Based on this good work:
# Librarian-puppet-vagrant

inspired by https://github.com/purple52/librarian-puppet-vagrant
also: http://pivotallabs.com/spinning-useful-vms-quickly-vagrant-puppet-puppet-forge/

This is a little example framework that shows how you can use
[Librarian-puppet](https://github.com/rodjek/librarian-puppet) to manage
[Puppet](http://puppetlabs.com/) modules when provisioning a virtual machine
managed using [Vagrant](http://vagrantup.com).

## Why?

No-one likes re-inventing the wheel, but using existing Puppet modules can be a
fiddle unless you use something to manage download and installation. If you're
using Vagrant and stand-alone Puppet to manage a VM, it can be even more of a fiddle.
Do you clone the modules from various git repositories? Create them as submodules
in your own repository? Install them on the host, or on the guest?

[Librarian-puppet](https://github.com/rodjek/librarian-puppet) can help by managing the
Puppet modules used by your Vagrant box. But, there is a problem: you can't use Puppet
to install Librarian-puppet because your Puppet manifests won't compile until your
modules are installed.

## Solution

The simple solution implemented here uses a shell provisioner in your Vagrant
configuration to install and run Librarian-puppet before your Puppet provisioner runs.

## How to use

This repository is really just a template; copy the relevant files into your
own project. Here's a breakdown of what's required:

* `Vagrantfile` - the included example has three important sections:
    + A VirtualBox configuration line to allow symlinking in your Vagrant root
    + A shell provisioner definition
    + A Puppet provisioner definition
* `shell/main.sh` - a simple shell provisioner to install and run Librarian-puppet.
Note that it requires git to be installed on your VM, so either install it on your basebox
or add a line in the shell provisioner to install it; an example is in the file. You also need to
configure this script to install Puppet modules in the correct place. By default, it will put them
in `/etc/puppet`.
* `puppet/Puppetfile` - configuration describing what Puppet modules to install. See the
[Librarian-puppet](https://github.com/rodjek/librarian-puppet) project for details.
* `puppet/manifests/main.pp` - your main Puppet manifest.
* `puppet/.gitignore` - configured to ignore temporary directories and files created by Librarian-puppet.

## Contribute

Patches and suggestions welcome.

## Issues

Please raise issues via the github issue tracker.

## License

Please see the [LICENSE](https://github.com/purple52/librarian-puppet-vagrant/blob/master/LICENSE)
file.
