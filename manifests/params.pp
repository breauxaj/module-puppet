# Class: puppet::params
#
# This class sets parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#
class puppet::params {
  case $::operatingsystem {
    'amazon': {
      $puppet_packages = [
        'augeas',
        'facter2',
        'puppet3',
      ]
    }
    'centos', 'redhat': {
      $puppet_packages = [
        'augeas',
        'facter',
        'puppet'
      ]
    }
    'debian', 'ubuntu': {
      $puppet_packages = [
        'augeas-lenses',
        'facter',
        'puppet'
      ]
    }
    default: {
      fail("Unsupported version: ${::operatingsystem}")
    }
  }

  file { '/etc/puppet':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }

  file { '/var/lib/puppet':
    ensure  => directory,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0755',
    require => [
      User['puppet'],
      Group['puppet']
    ]
  }

  group { 'puppet':
    ensure => present,
    gid    => 52,
  }

  user { 'puppet':
    ensure     => present,
    gid        => 52,
    home       => '/var/lib/puppet',
    shell      => '/bin/false',
    managehome => true,
    uid        => 52,
  }

}
