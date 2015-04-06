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
