# Class: puppet::params
#
# This class sets parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#
class puppet::params {
  $puppet_package_ensure = 'latest'

  $puppet_apply    = hiera('puppet::apply','apply.sh')
  $puppet_home     = hiera('puppet::home','/etc/puppet')

  $puppet_minute   = fqdn_rand(60)
  $puppet_hour     = '*'
  $puppet_monthday = '*'
  $puppet_month    = '*'
  $puppet_weekday  = '*'

  $puppet_service = 'puppet'

  file { $puppet_home:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }

  case $::operatingsystem {
    'Amazon': {
      $puppet_packages = [
        'augeas',
        'facter2',
        'puppet3',
      ]
    }
    'CentOS', 'OracleLinux', 'RedHat', 'Scientific': {
      $puppet_packages = [
        'augeas',
        'facter',
        'puppet'
      ]
    }
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
    'Ubuntu': {
      case $::operatingsystemrelease {
        '14.04': {
          $puppet_packages = [
            'augeas-lenses',
            'facter',
            'puppet'
          ]
        }
        '16.04': {
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
    default: {
      fail("The ${module_name} module is not supported on an ${::operatingsystem} based system.")
    }
  }
}
