#
# resolvconf module
#
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Haerry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
# Copyright 2015, Antoine Beaupré <anarcat@koumbit.org>
#
# This program is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License version 3 as published by
# the Free Software Foundation.
#

class resolvconf(
  String $domain = $facts['domain'],
  String $search = $facts['domain'],
  Array[Stdlib::IP::Address::Nosubnet,1]
    $nameservers = [ '8.8.8.8' ],
  Optional[String]
    $tail        = undef,
) {
  $content = $facts['operatingsystem'] ? {
    "OpenBSD" => template("resolvconf/resolvconf.${facts['operatingsystem']}.erb"),
    default   => template('resolvconf/resolvconf.erb'),
  }
  file{'/etc/resolv.conf':
    content => $content,
    owner   => root,
    group   => 0,
    mode    => '0444';
  }
}
