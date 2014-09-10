#!/usr/bin/ruby
require 'socket'
require 'digest'
require 'json'
require './auth'
require './sysinfo'

class RemoteServer
  include Auth
  include Sysinfo
  MULTICAST_ADDR = "224.0.0.1"
  MULTICAST_PORT = 6660


  def initialize
    @mediafiles = ['avi', 'flv', 'mkv', 'mp4', 'mpeg', 'mpg', 'ts', 'vob', 'webm', 'wmv']
    @port = 6660
    @home = homedir
    @password="liserginka"
    @hostname=hostname
    @ipaddr  = ipaddr
    @user = username
  end

  def random_string length=50
    if not @symbol_array
      @symbol_array = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    end
    (0...length).map { @symbol_array[rand(@symbol_array.length)] }.join
  end

  def start_multicaster
    Thread.start do
      
      puts "Start UDP notifier"
      socket = UDPSocket.open
      socket.setsockopt(:IPPROTO_IP, :IP_MULTICAST_TTL, 1)
      puts "UDP socket opened!"

      myinfo = {
        'ip' => @ipaddr,
        'port' => @port,
        'hostname' => @hostname,
        'user' => @user,
        'id' => "#{@user}@#{@hostname}"
        }

      info_json = myinfo.to_json

      loop {
        myinfo = Hash.new
        socket.send(info_json, 0, MULTICAST_ADDR, MULTICAST_PORT)
        sleep 1
      }
      socket.close
    end
  end

  def send_hash client, object
    client.write  Hash[*object.map {|k,v| p k.to_s,v}.flatten].to_json
  end

  def start
    @server = TCPServer.open(@port)
    start_multicaster
    loop {
      Thread.start(@server.accept) do |client|
        puts "client connected"
        key = random_string
        good_key = validation_key key


        client.send_hash lock: key, type: "auth_key"
        answer = client.read_hash
        checked_key = answer[:key]

        if checked_key == good_key
          client.send_hash type: "auth", result: "ok"
          loop do
            request = client.read_hash

            if [:play, :fullscreen, :forward1, :next_osd,
              :forward2, :forward3, :rewind1, :rewind2,
              :rewind3, :increase_volume, :decrease_volume].include?request[:type].to_sym
                IO.popen ['smplayer', '-send-action', request[:type]]
              next
            end

            case request[:type].to_sym
            when :play_pause
              IO.popen ['smplayer', '-send-action', 'pause']
            when :prev
              IO.popen ['smplayer', '-send-action', 'pl_prev']
            when :next
              IO.popen ['smplayer', '-send-action', 'pl_next']
            when :play_file
              IO.popen ['smplayer', '-send-action', 'quit']
              sleep 0.5
              `killall smplayer`
              IO.popen ['smplayer', request[:path]]
            when :quit
              IO.popen ['smplayer', '-send-action', 'quit']
              sleep 0.5
              `killall smplayer`
            when :alert
              IO.popen ['xrandr', '-o', %w(normal inverted left right).sample]

            when :ls
              base_dir = request[:path]
              base_dir ||= @home
              ls =  Dir.entries("#{base_dir}").select {|n| not n.start_with? '.'}.map {|n| File.join base_dir, n}
              dirs = ls.select {|f| File.directory? f}.sort
              files = ls.select { |f| !File.directory?(f) && ( @mediafiles.include? f.split('.')[-1].downcase)}.sort
              dirs = dirs.map {|path| Hash type: :dir, path: path, name: File.basename(path)}
              dirs.unshift(Hash type: :dir, path: File.dirname(base_dir), name: "..")
              files = files.map do |path| 
                Hash type: :file, path: path, name: File.basename(path), ext: path.split('.')[-1].downcase
              end
              object = {type: :files, pwd: base_dir, name: File.basename(base_dir), dirs: dirs, files: files}

              client.send_hash object
            end#case

          end #loop
        else
          client.send_hash type: "auth", result: "failed"
        end
        
        client.close
      end
    }
  end
end

class TCPSocket
  def send_hash object
    write object.to_json
  end
  def read_hash
    Hash[*JSON.parse(recv(5024)).map {|k,v| [k.to_sym, v] }.flatten]
  end
end
case ARGV[0]
when '--help'
  puts 'satanyasha -d'
  puts '  run as daemon'
  exit 0
when '-d'
  pid = fork do
    server = RemoteServer.new
    server.start
  end
  exit
end

server = RemoteServer.new
server.start
