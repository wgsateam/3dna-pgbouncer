# == Class pgbouncer::config
#
# This class is called from pgbouncer
#
class pgbouncer::config inherits pgbouncer {
  concat { $configfile:
    owner => 'postgres',
    group => 'postgres',
    mode  => '0640',
  }

  concat::fragment { 'pgbouncer main config':
    target  => $configfile,
    order   => '00',
    content => template('pgbouncer/pgbouncer.ini.erb'),
  }

  concat { $auth_file:
    owner => 'postgres',
    group => 'postgres,',
    mode  => '0640',
  }

  concat::fragment { 'pgbouncer user list header':
    target  => $auth_file,
    order   => '00',
    content => '# this file managed by puppet, do not edit it!',
  }
}
