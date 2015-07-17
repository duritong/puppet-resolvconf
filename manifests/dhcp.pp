class resolvconf::dhcp(
  $tail,
)
{
  package { 'resolvconf': ensure => installed, }
  if $tail {
    file { '/etc/resolvconf/resolv.conf.d/tail':
      content => $tail,
      require => Package['resolvconf'],
    }
  }
}
