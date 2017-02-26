# Class: mysql
#
class mysql {

  $root_password = 'passwordsecret'
  $bin = '/usr/bin:/usr/sbin'

  if ! defined(Package['mysql-server']) {
    package { ['mysql-server']:
    ensure  => latest,
    require => Exec['update'],
    }
  }

  service { 'mysql':
    ensure     => 'running',
    enable     => true,
    alias      => 'mysql::mysql',
    hasstatus  => true,
    hasrestart => true,
    require    => Package['mysql-server'],
  }

  # Set the root password.
  exec { 'mysql::set_root_password':
    unless  => "mysqladmin -uroot -p${root_password} status",
    command => "mysqladmin -uroot password ${root_password}",
    path    => $bin,
    require => Service['mysql::mysql'],
  }

  exec { '/usr/bin/perl -pi -e "s/^.*bind-address.*$/bind-address = 0.0.0.0/" "/etc/mysql/my.cnf"':
    onlyif  => '/bin/grep "bind-address.*\=.*127\.0\.0\.1" /etc/mysql/my.cnf',
    require => Package['mysql-server'],
    notify  => Service['mysql'],
  }

  exec { 'grant_root':
    unless  => "/usr/bin/mysql -uroot -p${root_password}",
    command => "/usr/bin/mysql -uroot -e \"grant all on *.* to 'root'@'%' IDENTIFIED BY '${root_password}';\"",
    require => Package['mysql-server'],
  }
}
