# Class: sphinx::params
#
#
class sphinx::params {
  # TODO: refactor this var to a common module and make other module use it
	$os_suffix = $operatingsystem ? {
		/(?i)(Debian|Ubuntu)/ => 'debian',
		/(?i)(RedHat|CentOS)/ => 'redhat',
	}
	
  # Installing from source
	$unpack_root = $sphinx_unpack_root ? {
		''      => '/usr/src',
		default => $sphinx_unpack_root,
	}
	
	$configdir = $sphinx_configdir ? {
		''      => '/etc/sphinxsearch',
		default => $sphinx_configdir,
	}
	
	$configfile = $sphinx_configfile ? {
		''      => "${configdir}/sphinx.conf",
		default => $sphinx_configfile,
	}
	
	$configfile_content = $sphinx_configfile_content ? {
	 ''      => undef,
	 default => template($sphinx_configfile_content),
	}
	
	$configfile_source = $sphinx_configfile_source ? {
	 ''      => undef,
	 default => $sphinx_configfile_content,
	}
	
	$libdir = $sphinx_libdir ? {
		''      => '/var/lib/sphinx',
		default => $sphinx_libdir,
	}
	
	$logdir = $sphinx_logdir ? {
		''      => '/var/log/sphinx',
		default => $sphinx_logdir,
	}
	
	$pidfile = $sphinx_pidfile ? {
    ''      => '/var/run/searchd.pid',
    default => $sphinx_pidfile,
	}
	
	$dbdir = $sphinx_dbdir ? {
    ''      => "${libdir}/db",
    default => $sphinx_dbdir,
	}
	
	$version = $sphinx_version ? {
	 ''      => '0.9.9',
	 default => $sphinx_version,
	}
}
