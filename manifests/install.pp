# == Class pgbouncer::install
#
class pgbouncer::install inherits pgbouncer {

  package { $pgbouncer::package_name:
    ensure => present,
  }
}
