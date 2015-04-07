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

# Add github to known hosts
include github

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

# Install and Setup RVM
class { 'rvm': }
rvm::system_user { vagrant: ; root: ; }

rvm_system_ruby {
  'ruby-2.0':
    ensure      => 'present',
    default_use => false;
  'ruby-2.1':
    ensure      => 'present',
    default_use => false;
  'ruby-2.2':
    ensure      => 'present',
    default_use => true;
}

rvm_gem {
  'bundler-2.0':
    name         => 'bundler',
    ruby_version => 'ruby-2.0',
    ensure       => latest,
    require      => Rvm_system_ruby['ruby-2.0'];
}

rvm_gem {
  'bundler-2.1':
    name         => 'bundler',
    ruby_version => 'ruby-2.1',
    ensure       => latest,
    require      => Rvm_system_ruby['ruby-2.1'];
}

rvm_gem {
  'bundler-2.2':
    name         => 'bundler',
    ruby_version => 'ruby-2.2',
    ensure       => latest,
    require      => Rvm_system_ruby['ruby-2.2'];
}

rvm_gem {
  'librarian-puppet-2.2':
    name         => 'librarian-puppet',
    ruby_version => 'ruby-2.2',
    ensure       => latest,
    require      => Rvm_system_ruby['ruby-2.2'];
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

# Install TMuxinator
rvm_gem {
  'tmuxinator-2.2':
    name         => 'tmuxinator',
    ruby_version => 'ruby-2.2',
    ensure       => latest,
    require      => [Rvm_system_ruby['ruby-2.2'], Class['::tmux']];
}

file { '/home/vagrant/.tmuxinator':
  ensure => 'link',
  target => '/vagrant/dotfiles/.tmuxinator',
  mode => 0755,
  force => true,
  replace => true,
}
