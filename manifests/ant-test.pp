
exec { "ant":
	cwd	=> "/home/vagrant/gsn",
        command => "/usr/bin/ant",
	timeout => 600,
	logoutput => true,
}

exec { "ant-gsn":
	cwd 	=> "/home/vagrant/gsn",
        command => "/usr/bin/ant gsn",
	logoutput => true,
}



