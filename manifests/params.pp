# Class: puppet::params
#
# This class sets parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#
class puppet::params {
  $puppet_minute   = '*/15'
  $puppet_hour     = '*'
  $puppet_monthday = '*'
  $puppet_month    = '*'
  $puppet_weekday  = '*'

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

  case $::osfamily {
    'Debian': {
      case $::operatingsystemmajrelease {
        '8': {
          $puppet_packages = [
            'augeas-lenses',
            'facter',
            'puppet'
          ]
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} ${::operatingsystemmajrelease} distribution.")
        }
      }
    }
    'RedHat': {
      case $::operatingsystemmajrelease {
        '6': {
          $puppet_packages = [
            'augeas',
            'facter',
            'puppet'
          ]
        }
        '7': {
          $puppet_packages = [
            'augeas',
            'facter',
            'puppet'
          ]
        }
        '2016': {
          $puppet_packages = [
            'augeas',
            'facter2',
            'puppet3',
          ]
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} ${::operatingsystemmajrelease} distribution.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}