exec { 'update':
  command => '/usr/bin/apt-get update'
}

node 'vmysql'{
  class { 'mysql':}
}
