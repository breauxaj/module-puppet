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

  $puppet_branch   = '/etc/puppet_branch'

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

  file { $puppet_branch:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $::puppet_branch,
  }

  case $::osfamily {
    'RedHat': {
      $puppet_packages = [
        'augeas',
        'facter',
        'puppet'
      ]
    }
    'Debian': {
      $puppet_packages = [
        'augeas-lenses',
        'facter',
        'puppet'
      ]
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
