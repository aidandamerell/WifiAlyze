#!/usr/bin/env ruby
require 'packetfu'
require 'colorize'
require 'pp'

banner = '        .__  _____.__       .__                        
__  _  _|__|/ ____\__|____  |  | ___.__.________ ____  
\ \/ \/ /  \   __\|  \__  \ |  |<   |  |\___   // __ \ 
 \     /|  ||  |  |  |/ __ \|  |_\___  | /    /\  ___/ 
  \/\_/ |__||__|  |__(____  /____/ ____|/_____ \\___  >
                          \/     \/           \/    \/ '

system 'clear'
puts banner.green

def hue_flash
	#Get a light to flash when a questionable packet is seen
end

#Read ports list
ports = []
ports_file = File.readlines('ports.txt')

ports_file.each do |p|
	ports << p.chomp.to_i
end

interface = ARGV[0]
cap = PacketFu::Capture.new(:iface => "#{interface}", :start => true, :promisc => true)

stats = Hash.new(0)
stats[:types] = Hash.new(0)



puts "-----------------------".green
puts "Monitoring on: #{interface}".light_blue
puts "-----------------------".green
previous_port = 0
cap.stream.each do | packet |
	begin
		packet_info = PacketFu::Packet.parse(packet)
		eth_source = packet_info.eth_dst_readable
		source = packet_info.ip_saddr
		destination = packet_info.ip_dst_readable
		tcp_port = packet_info.tcp_dst
		if ports.include? tcp_port
			stats[:types][tcp_port] += 1 

			open('log.txt', 'a') { |f|
			f.puts "-----------------------------"
			f.puts "Source: " + source
			f.puts "Destination: " + destination
			f.puts "Source MAC: " + eth_source
			f.puts "Port: " + tcp_port.to_s
			f.puts Time.now.to_s
			f.puts "-----------------------------"
			}
			system('clear')
			puts banner.green
  			stats.each do |k,v|
  				puts "Port => Packets"
  				v.each do |port, count|
  					puts "#{port} => #{count}".red
  				end
  			end
		  end
		rescue
	end
end