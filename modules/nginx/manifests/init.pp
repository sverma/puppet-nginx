class nginx { 
	package { nginx: 
		ensure => present,
	}
	file { '/usr/share/nginx/www/':
		ensure => 'directory',
		before => File['/usr/share/nginx/www/info.php'],
	}
	file { '/usr/share/nginx/www/info.php':
		ensure  => file,
		content => template('nginx/info.php.erb'),
	} 
	file { '/etc/nginx/sites-enabled/default':
		ensure  => file,
		notify  => Service['nginx'],
		content => template('nginx/default.erb'),
	} 
	service { 'nginx':
   		ensure  => 'running',
    		enable  => true,
    		require => Package['nginx'],
  	}

}
class php5-fpm { 
	package { php5-fpm: 
		ensure => present, 
	} 
}

