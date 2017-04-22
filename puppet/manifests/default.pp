exec { 'update':
  command => '/usr/bin/apt-get update'
}

node 'mysql.loc'{
  class { 'mysql':}
}
