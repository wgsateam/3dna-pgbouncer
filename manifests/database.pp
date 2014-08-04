# == Define pgbouncer::database
#
# defines a database for pgbouncer to service
# "hard" parameters take precedence over options supplied through the options hash
# currently, the "connect_query" option needs to be extra quoted because of how it's set up in the template
# example: options => { connect_query => '"select 1"' }
# I hope to fix this in a later version
#
define pgbouncer::database (
  $dbname   = $title,
  $database = undef,
  $user     = undef,
  $password = undef,
  $host     = undef,
  $port     = undef,
  $options  = {},
) {
  include pgbouncer

  validate_hash($options)

  $real_options = merge($options, {
    database => $database,
    user     => $user,
    password => $password,
    host     => $host,
    port     => $port,
  })

  concat::fragment { "pgbouncer_database_$name":
    target  => $pgbouncer::configfile,
    order   => "20_database_10_$name",
    content => template('pgbouncer/pgbouncer.ini.database_fragment.erb'),
  }
}
