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
