class profiles::apache_wls {
  # Place plugin Apache config
  file { '/etc/httpd/conf.d/apache_wls.conf':
    ensure => 'present',
    owner => 'apache',
    group => 'apache',
    mode => '0644',
    source => 'puppet:///modules/profiles/apache_wls.conf',
    require => Package['httpd'],
  }
  # Add lib to LD_LIBRARY_PATH
  file { '/etc/ld.so.conf.d/apache_wls.conf':
    ensure => 'present',
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => '/opt/carelink/wls_plugin/lib',
    require => File['/etc/httpd/conf.d/apache_wls.conf'],
    notify => Exec['ldlibcfg']
  }
  # need to re-rerun ldconfig after installing WL plugin
  exec { 'ldlibcfg':
    command => '/sbin/ldconfig',
    refreshonly => true,
    notify => Service['httpd'],
  }
}
