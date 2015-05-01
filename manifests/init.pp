package { "vim-enhanced":
          ensure => installed,
}

package { "java-1.7.0-openjdk-devel":
		  ensure => installed,
}	


package {"ant":
		 ensure => installed,
	     require => Package['java-1.7.0-openjdk-devel'],
}

include git

class git {
	package { "git":
		  ensure => installed,
	}
	file { "/home/vagrant" :
		ensure => present,
	}
		
	exec { "git-clone":
		command => "/usr/bin/git clone <> gsn",
		cwd 	=> "/home/vagrant/",
      	        creates => "/home/vagrant/gsn",
		require => [Package["git"], File["/home/vagrant/"]],
	}
}



package {
		"pgdg-centos94":
		provider => 'rpm',
		source => 'http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm',
		ensure => installed,
}

package { "postgresql94-server":
		   ensure => installed,
		   require => Package["pgdg-centos94"],
}

file { "/opt/gsn_data":
    ensure => "directory",
    owner  => "postgres",
}

exec { "initdb":
	command => "su - postgres -c '/usr/pgsql-9.4/bin/initdb  -D /opt/gsn_data'",
	path => [ "/usr/local/bin/", "/bin/", "/usr/bin/", "/sbin" ],
	require => [Package["postgresql94-server"], File['/opt/gsn_data']],
}


file { "/opt/gsn_data/pg_hba.conf":
   	ensure => present,
    source => '/vagrant/pg_hba.conf',
	owner => "postgres",
	require => [Package['postgresql94-server'], Exec['initdb']],
}

exec { 'postgresql-9.4':
      command => "su - postgres -c '/usr/pgsql-9.4/bin/pg_ctl  -D /opt/gsn_data -l logfile start'",
	  path => [ "/usr/local/bin/", "/bin/", "/usr/bin/", "/sbin" ],
      require   => [Package['postgresql94-server'], File['/opt/gsn_data/pg_hba.conf']],
}
 	

#create postgres db
exec { "setup-postgres":
        command => "/vagrant/setup-postgres.sh",
        require => [Package["postgresql94-server"], Exec["postgresql-9.4"]],
}

#start GSN
file { "/home/vagrant/gsn/conf/gsn.xml":
        ensure => present,
        source => '/vagrant/gsn.xml',
        require => [Package['postgresql94-server'], Exec['setup-postgres'], Class["git"]],
}

exec { "ant":
	cwd	=> "/home/vagrant/gsn",
    command => "/usr/bin/ant",
	timeout => 600,
	logoutput => true,
    require => [Package['ant'], Exec['setup-postgres'], File["/home/vagrant/gsn/conf/gsn.xml"]],
}

exec { "ant-gsn":
	cwd 	=> "/home/vagrant/gsn",
    command => "/usr/bin/ant gsn",
	logoutput => true,
    require => [Package["postgresql94-server"], Class["git"], Exec['ant']],
}


#service { 'iptables':
#      ensure    => stop,
#      enable    => false,
#}