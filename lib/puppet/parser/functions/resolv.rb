#
# resolv.rb
#
require 'resolv'

module Puppet::Parser::Functions
  newfunction(:resolv, :type => :rvalue, :doc => <<-EOS
Resolves a hostname (first argument) to its list of ipaddresses.

Takes a an array of nameserver as a second argument.

*Example:*

    resolv('nic.ch')

Would result in:

    [ IPs of nic.ch ]

*Example:*

    resolv('nic.ch',['8.8.8.8'])

Would result in (queried on 8.8.8.8 nameserver):

    [ IPs of nic.ch ]

    EOS
  ) do |arguments|

    # Technically we support three arguments but only first is mandatory ...
    raise(Puppet::ParseError, "resolv(): Wrong number of arguments " +
      "given (#{arguments.size} for 1 or 2)") unless [1,2].include?(arguments.size)

    domain = arguments[0]
    nameservers = Array(arguments[1])

    (nameservers.empty? ? Resolv.new : Resolv::DNS.new(:nameserver => nameservers)).getaddresses(domain)
  end
end

# vim: set ts=2 sw=2 et :
