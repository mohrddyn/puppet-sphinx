# Class: sphinx::config
#
#
class sphinx::config {
  file { '/etc/init.d/sphinxsearch':
		ensure  => present,
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		content => template("sphinx/init.${sphinx::params::os_suffix}.erb"),
		notify  => Class['sphinx::service'],
		require => Class['sphinx::install'],
	}
	
	file { $sphinx::params::configdir:
		ensure  => directory,
		owner   => 'root',
		group   => 'root',
		require => Class['sphinx::install'],
	}
	
	file { $sphinx::params::configfile:
		ensure  => present,
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		content => undef,
		source  => undef,
		require => File[$sphinx::params::configdir],
	}
	
	file { $sphinx::params::libdir:
		ensure  => directory,
		owner   => 'root',
		group   => 'root',
		require => Class['sphinx::install'],
	}
	
	file { $sphinx::params::logdir:
		ensure  => directory,
		owner   => 'root',
		group   => 'root',
		require => Class['sphinx::install'],
	}
	
	file { $sphinx::params::dbdir:
		ensure  => directory,
		owner   => 'root',
		group   => 'root',
		require => File[$sphinx::params::libdir],
	}
}
