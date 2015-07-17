#
# resolvconf DHCP support
#
# Copyright 2015, Antoine Beaupré <anarcat@koumbit.org>
#
# This program is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License version 3 as published by
# the Free Software Foundation.
#
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
