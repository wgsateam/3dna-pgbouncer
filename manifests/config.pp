#== Class pgbouncer::config
#
# This class is called from pgbouncer
#
class pgbouncer::config inherits pgbouncer {
  include pgbouncer::reload
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
  $pgbouncer_users_hash = deep_merge($::pgusers_hash,$::pgbouncer::admin_users,$::pgbouncer::stats_users)
  if $pgbouncer_users_hash {
    create_resources(pgbouncer::user, $pgbouncer_users_hash)
  }
}
