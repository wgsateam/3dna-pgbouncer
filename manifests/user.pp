# == Define pgbouncer::user
#
# defines a user for pgbouncer
#
define pgbouncer::user (
  $username = $title,
  $password = undef,
) {
  include pgbouncer

  concat::fragment { "pgbouncer_user_${name}":
    target  => $pgbouncer::auth_file,
    order   => "20_user_${name}x",
    content => "\"${username}\" \"${password}\"\n",
  }
}
