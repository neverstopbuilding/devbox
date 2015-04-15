$as_vagrant = 'sudo -u vagrant -H bash -l -c'
$home = '/home/vagrant'

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Packages -----------------------------------------------------------------
package { ['curl', 'gnupg', 'build-essential', 'git-flow', 'nodejs', 'libpq-dev']:
  ensure => installed
}

# --- Ruby ---------------------------------------------------------------------
exec { 'import_rvm_signature':
  command => "${as_vagrant} 'gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3'",
  require => Package['gnupg'],
  unless => "${as_vagrant} 'gpg --list-keys D39DC0E3'",
}

exec { 'install_rvm':
  command => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
  creates => "${home}/.rvm",
  require => [Package['curl'], Exec['import_rvm_signature']],
  logoutput => true
}

exec { 'install_ruby-2.0.0':
  command => "${as_vagrant} '${home}/.rvm/bin/rvm install ruby-2.0.0 --autolibs=enabled'",
  unless => "${as_vagrant} '${home}/.rvm/bin/rvm list | grep 2.0.0'",
  timeout => 600,
  require => Exec['install_rvm'],
  logoutput => true
}

exec { 'install_ruby-2.1.5':
  command => "${as_vagrant} '${home}/.rvm/bin/rvm install ruby-2.1.5 --autolibs=enabled'",
  unless => "${as_vagrant} '${home}/.rvm/bin/rvm list | grep 2.1.5'",
  timeout => 600,
  require => Exec['install_rvm'],
  logoutput => true
}

exec { 'install_ruby-2.2.2':
  command => "${as_vagrant} '${home}/.rvm/bin/rvm install ruby-2.2.2 --autolibs=enabled'",
  unless => "${as_vagrant} '${home}/.rvm/bin/rvm list | grep 2.2.2'",
  timeout => 600,
  require => Exec['install_rvm'],
  logoutput => true
}

exec { 'set_default_ruby':
  command => "${as_vagrant} '${home}/.rvm/bin/rvm alias create default ruby-2.2.2 && ${home}/.rvm/bin/rvm use default'",
  unless => "${as_vagrant} '${home}/.rvm/bin/rvm list default | grep 2.2.2'",
  require => Exec['install_ruby-2.2.2'],
  logoutput => true
}

exec { 'install_bundler-2.2.2':
  cwd => $home,
  command => "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'",
  creates => "${home}/.rvm/gems/ruby-2.2.2/bin/bundler",
  require => Exec['set_default_ruby'],
  logoutput => true
}

exec { 'install_bundler-2.2.2-global':
  cwd => $home,
  command => "${as_vagrant} '${home}/.rvm/bin/rvm 2.2.2@global do gem install bundler --no-rdoc --no-ri'",
  creates => "${home}/.rvm/gems/ruby-2.2.2@global/bin/bundler",
  require => Exec['set_default_ruby'],
  logoutput => true
}

exec { 'install_bundler-2.1.5-global':
  cwd => $home,
  command => "${as_vagrant} '${home}/.rvm/bin/rvm 2.1.5@global do gem install bundler --no-rdoc --no-ri'",
  creates => "${home}/.rvm/gems/ruby-2.1.5@global/bin/bundler",
  require => Exec['install_ruby-2.1.5'],
  logoutput => true
}

exec { 'install_bundler-2.0.0-global':
  cwd => $home,
  command => "${as_vagrant} '${home}/.rvm/bin/rvm 2.0.0-p643@global do gem install bundler --no-rdoc --no-ri'",
  creates => "${home}/.rvm/gems/ruby-2.0.0-p643@global/bin/bundler",
  require => Exec['install_ruby-2.0.0'],
  logoutput => true
}

exec { 'install_tmuxinator':
  cwd => $home,
  command => "${as_vagrant} 'gem install tmuxinator -v 0.6.9 --no-rdoc --no-ri'",
  creates => "${home}/.rvm/gems/ruby-2.2.2/bin/tmuxinator",
  require => [Exec['set_default_ruby'], Class['::tmux']],
  logoutput => true
}

# --- NodeJS--------------------------------------------------------------------
class { 'nodejs':
  version => 'stable',
}

# Install OhMyZSH
class { 'ohmyzsh': }
ohmyzsh::install { ['root', 'vagrant']: }

# Link to canonical .zshrc
file { '/home/vagrant/.zshrc':
  ensure => link,
  mode => 0755,
  target => '/vagrant/dotfiles/.zshrc',
  require => Class['ohmyzsh']
}

# Link to canonical .gitconfig
file { '/home/vagrant/.gitconfig':
  ensure => link,
  mode => 0755,
  target => '/vagrant/dotfiles/.gitconfig',
}

# Link to canonical .gitconfig
file { '/home/vagrant/.gemrc':
  ensure => link,
  mode => 0755,
  target => '/vagrant/dotfiles/.gemrc',
}

# Hush Login
package { 'update-motd':
  ensure => 'purged'
}

package { 'landscape-common':
  ensure => 'purged'
}

file { '.hushlogin':
  path => '/home/vagrant/.hushlogin',
  ensure => present,
  mode => 0640
}

# Install TMUX
class { '::tmux': }
File <| title == '/etc/tmux.conf' |> {
  ensure => link,
  mode => 0755,
  content => undef,
  source => undef,
  target => '/vagrant/dotfiles/tmux.conf',
}

file { '/home/vagrant/.tmuxinator':
  ensure => 'link',
  target => '/vagrant/dotfiles/.tmuxinator',
  mode => 0755,
  force => true,
  replace => true,
  require => Exec['install_tmuxinator']
}

# Link .vimrc
file { '/home/vagrant/.vimrc':
  ensure => link,
  mode => 0755,
  target => '/vagrant/dotfiles/.vimrc',
}

# Install vundle
vcsrepo { '/home/vagrant/.vim/bundle/Vundle.vim':
	ensure => present,
	provider => git,
	source => "https://github.com/gmarik/Vundle.vim.git",
	user => 'vagrant'
}

# Configure postgres
class { 'postgresql::globals':
  encoding => 'UTF-8',
  locale   => 'en_US.UTF-8',
}->
class { 'postgresql::server':
}

class { 'postgresql::client': }

class { 'postgresql::server::contrib': }

postgresql::server::role { 'vagrant':
  createdb => true,
  createrole => true,
  superuser => true
}
