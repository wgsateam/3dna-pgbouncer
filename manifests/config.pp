#== Class pgbouncer::config
#
# This class is called from pgbouncer
#
class pgbouncer::config inherits pgbouncer {
  concat { $::pgbouncer::configfile:
    owner  => $::pgbouncer::owner,
    group  => $::pgbouncer::group,
    mode   => '0640',
  }

  concat::fragment { 'pgbouncer main config':
    target  => $::pgbouncer::configfile,
    order   => '00',
    content => template('pgbouncer/pgbouncer.ini.erb'),
  }

  concat { $::pgbouncer::auth_file:
    owner  => $::pgbouncer::owner,
    group  => $::pgbouncer::group,
    mode   => '0640',
  }

  concat::fragment { 'pgbouncer user list header':
    target  => $::pgbouncer::auth_file,
    order   => '00',
    content => '',
  }

  create_resources(pgbouncer::user, $::pgbouncer::admin_users)
  create_resources(pgbouncer::user, $::pgbouncer::stats_users)

  if $::pgbouncer::sync_pg_users and $::pgusers_hash {
    create_resources(pgbouncer::user, $::pgusers_hash)
  }
}
