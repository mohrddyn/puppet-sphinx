# Class: sphinx::install
#
#
class sphinx::install {
  include buildenv::c
	include buildenv::packages::mysql
	
	common::archive { "sphinx-${sphinx::params::version}":
		ensure   => present,
		checksum => false,
		url      => "http://sphinxsearch.com/files/sphinx-${sphinx::params::version}.tar.gz",
		timeout  => 600,
		target   => '/usr/src',
	}
	
	common::archive { "libstemmer":
		ensure   => present,
		checksum => false,
		url      => "http://snowball.tartarus.org/dist/libstemmer_c.tgz",
		timeout  => 600,
		target   => "/usr/src/sphinx-${sphinx::params::version}",
		notify   => Exec['configure-sphinx'],
		require	 => Common::Archive["sphinx-${sphinx::params::version}"],
	}
	
	exec { 'configure-sphinx':
		command     => "/usr/src/sphinx-${sphinx::params::version}/configure --with-libstemmer",
		cwd         => "/usr/src/sphinx-${sphinx::params::version}",
		creates     => "/usr/src/sphinx-${sphinx::params::version}/Makefile",
		refreshonly => true,
		notify		  => Exec['make-sphinx'],
		require     => [ Common::Archive['libstemmer'], Class['buildenv::c'],
		                 Class['buildenv::packages::mysql'] ],
	}

	exec { 'make-sphinx':
		command     => '/usr/bin/make',
		cwd         => "/usr/src/sphinx-${sphinx::params::version}",
		creates     => "/usr/src/sphinx-${sphinx::params::version}/src/searchd",
		refreshonly => true,
		notify		  => Exec['make-install-sphinx'],
		require     => Exec['configure-sphinx'],
	}

	exec { 'make-install-sphinx':
		command     => '/usr/bin/make install',
		cwd         => "/usr/src/sphinx-${sphinx::params::version}",
		creates     => '/usr/local/bin/searchd',
		refreshonly => true,
		require     => Exec['make-sphinx'],
	}
}
