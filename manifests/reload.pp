# == Class pgbouncer::reload
#
# This class is meant to be called from pgbouncer
# It calls reload config/userlists
#
class pgbouncer::reload inherits pgbouncer {

  exec { 'pgbouncer_reload':
    path        => '/usr/bin:/usr/sbin:/bin:/sbin',
    command     => 'service pgbouncer reload',
    refreshonly => true,
    require     => Class['pgbouncer::service'],
    subscribe   => Class['pgbouncer::config']
  }
}
