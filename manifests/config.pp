# == Class pg_monz::config
#
# This class is called from pg_monz for configuring pg_monz.
#
class pg_monz::config {

  file { '/etc/pg_monz/pgsql_funcs.conf' :
    ensure  => present,
    owner   => $::pg_monz::zabbix_user,
    group   => $::pg_monz::zabbix_group,
    mode    => '0600',
    content => template('pg_monz/pgsql_funcs.conf.erb'),
    require => File['/etc/pg_monz'],
  }

  file { '/etc/pg_monz/pgpool_funcs.conf' :
    ensure  => present,
    owner   => $::pg_monz::zabbix_user,
    group   => $::pg_monz::zabbix_group,
    mode    => '0600',
    content => template('pg_monz/pgpool_funcs.conf.erb'),
    require => File['/etc/pg_monz'],
  }

  $data = $::pg_monz::userparameters
    
  file { '/etc/zabbix/zabbix_agentd.d/userparameter_pg_monz.conf' :
    ensure  => present,
    owner   => $::pg_monz::zabbix_user,
    group   => $::pg_monz::zabbix_group,
    mode    => '0640',
    content => template('pg_monz/userparameter_pg_monz.conf.erb'),
    require => Staging::Extract["pg_monz-${::pg_monz::version}.tar.gz"],
  }

}
