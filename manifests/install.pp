# == Class pgbouncer::install
#
class pgbouncer::install inherits pgbouncer {

  package { $pgbouncer::package_name:
    ensure => present,
  }


  if "${::operatingsystem}${::operatingsystemmajrelease}" == 'CentOS7' {
    include systemd
    file { '/etc/systemd/system/pgbouncer.service':
      ensure  => file,
      source  => 'puppet:///modules/pgbouncer/pgbouncer.service',
      require => Package[$pgbouncer::package_name],
      mode    => '0644',
    }
    ~>
    Exec['systemctl-daemon-reload']
    ~>
    Service[$pgbouncer::service_name]
  }
}
