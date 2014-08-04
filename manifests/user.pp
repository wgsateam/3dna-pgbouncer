# == Define pgbouncer::database
#
# defines a database for pgbouncer to service
# "hard" parameters take precedence over options supplied through the options hash
# currently, the "connect_query" option needs to be extra quoted because of how it's set up in the template
# example: options => { connect_query => '"select 1"' }
# I hope to fix this in a later version
#
define pgbouncer::database (
  $username = $title,
  $password = undef,
) {
  include pgbouncer

  concat::fragment { "pgbouncer_user_$name":
    target  => $pgbouncer::auth_file,
    order   => "20_user_$name",
    content => "\"${username}\" \"${password}\"",
  }
}
