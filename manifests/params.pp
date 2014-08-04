# == Class pgbouncer::params
#
# This class is meant to be called from pgbouncer
# It sets variables according to platform
#
class pgbouncer::params {
  $logfile = '/var/log/postgresql/pgbouncer.log'
  $pidfile = '/var/run/postgresql/pgbouncer.pid'
  $auth_file = '/etc/pgbouncer/userlist.txt'
  $configfile = '/etc/pgbouncer/pgbouncer.ini'
  
  case $::osfamily {
    'Debian': {
      $package_name = 'pgbouncer'
      $service_name = 'pgbouncer'
      $unix_socket_dir = '/var/run/postgresql'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
