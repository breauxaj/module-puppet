# Class: puppet
#
# This class installs puppet packages and manages the cron job for standalone
#
# Parameters:
#
#  ensure: (default latest)
#    Determine the state of the packages
#
# Actions:
#   - Installs the list of packages
#   - Manage the cron job for apply.sh
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'puppet':
#      ensure => 'latest'
#    }
#
class puppet (
  $ensure = $::puppet::params::puppet_package_ensure
) inherits ::puppet::params {
  package { $::puppet::params::puppet_packages:
    ensure  => $ensure,
  }

}
