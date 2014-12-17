#== Class pgbouncer::config
#
# This class is called from pgbouncer
#
class pgbouncer::config inherits pgbouncer {
  concat { $configfile:
    owner   => $owner,
    group   => $group,
    mode    => '0640',
  }

  concat::fragment { 'pgbouncer main config':
    target  => $configfile,
    order   => '00',
    content => template('pgbouncer/pgbouncer.ini.erb'),
  }

  concat { $auth_file:
    owner   => $owner,
    group   => $group,
    mode    => '0640',
  }

  concat::fragment { 'pgbouncer user list header':
    target  => $auth_file,
    order   => '00',
    content => '',
  }

  create_resources(pgbouncer::user, $admin_users)
  create_resources(pgbouncer::user, $stats_users)

  if $sync_pg_users and $::pgusers_hash {
    create_resources(pgbouncer::user, $::pgusers_hash)
  }
}
