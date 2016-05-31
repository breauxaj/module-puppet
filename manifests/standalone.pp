define puppet::standalone  (
  $minute = $puppet::params::puppet_minute,
  $hour = $puppet::params::puppet_hour,
  $monthday = $puppet::params::puppet_monthday,
  $month = $puppet::params::puppet_month,
  $weekday = $puppet::params::puppet_weekday
) {
  include ::puppet

  cron { 'puppet':
    command  => '/etc/puppet/apply.sh > /dev/null 2>&1',
    user     => 'root',
    minute   => $minute,
    hour     => $hour,
    monthday => $monthday,
    month    => $month,
    weekday  => $weekday,
  }

  cron { 'reports':
    command  => '/usr/local/sbin/reports.sh > /dev/null 2>&1',
    user     => 'root',
    minute   => '0',
    hour     => '0',
    require  => File['/usr/local/sbin/reports.sh'],
  }

  file { '/usr/local/sbin/reports.sh':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/puppet/reports.sh'
  }

}
