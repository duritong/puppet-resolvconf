resolv.conf Puppet module
=========================

This module will manage `/etc/resolv.conf` through Puppet.

resolvconf class
----------------

The main class (`resolvconf`) takes a simple list of nameservers as an
array. For example:

    class { 'resolvconf':
        nameservers => [ '8.8.8.8' ],
    }

... will create a `resolv.conf` that searches the domain name of the
machine (the `$::domain` fact) and uses Google's recursive nameservers
(also the default). The domain name and search path can be overriden
with the `$domain` and `$search` parameters.

Extra options can be added at the end of the `resolv.conf` file with
the `$tail` argument.

See the `resolv.conf(5)` manpage for more information about those
parameters and the syntax of the resolv.conf file.

resolvconf::dhcp class
----------------------

For machines that are configured with DHCP, the `resolvconf` class
should simply not be included, and the DHCP client will take care of
managing the config file.

However, if you wish to add options to the resulting `resolv.conf`
file, you can use the `resolvconf::dhcp` class that will use the
`resolvconf` Debian package to apply extra options at the end of the
`resolv.conf` file. For example, this will ensure a faster fallback
in case of failures in the DHCP-provided nameservers:

    class { 'resolvconf::dhcp':
        tail => 'options timeout:1 attempts:3 rotate',
    }

License
-------

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License version 3 as
published by the Free Software Foundation.
