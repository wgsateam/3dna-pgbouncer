# == Class pgbouncer::install
#
class pgbouncer::install inherits pgbouncer {

  package { $pgbouncer::package_name:
    ensure => present,
  }

  file { $pgbouncer::params::logfile:
    ensure  => file,
    owner   => $pgbouncer::params::owner,
    group   => $pgbouncer::params::group,
    mode    => '0640';
  }

  if "${::operatingsystem}${::operatingsystemmajrelease}" == 'CentOS7' {
    include systemd
    file { '/etc/systemd/system/pgbouncer.service':
      ensure  => file,
      source  => 'puppet:///modules/pgbouncer/pgbouncer.service',
      require => Package[$pgbouncer::package_name],
      mode    => '0644',
      notify  => Service[$pgbouncer::service_name],
    }
    ~>
    Exec['systemctl-daemon-reload']
    ->
    Service[$pgbouncer::service_name]
  }
}
