#!/usr/bin/ruby

require 'socket'

module Sysinfo
  def hostname
    Socket.gethostname
  end

  def ipaddr
    Socket.ip_address_list.detect{|intf| intf.ipv4_private?}.inspect_sockaddr
  end

  def homedir
    ENV['HOME']
  end

  def username
    ENV['USER']
  end

end

