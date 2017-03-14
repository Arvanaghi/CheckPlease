# ***
# Ruby sleep acceleration check by querying NTP server
# Module written by Brandon Arvanaghi (@arvanaghi)
# ***

require 'socket'

ntp_msg = (["00011011"] + Array.new(47,1)).pack("B8 C47")
sock = UDPSocket.new;sock.connect("us.pool.ntp.org", 123)
sock.print ntp_msg;sock.flush;
data,_ = sock.recvfrom(960)
sock.close

firstTime = Time.at(data.unpack("B319 B32 B32")[1].to_i(2) - 2208988800);
puts "NTP time before sleeping: #{firstTime}"
puts "Attempting to sleep for #{ARGV[0].to_i} seconds..."

sleep(ARGV[0].to_i)

sock = UDPSocket.new;sock.connect("us.pool.ntp.org", 123)
sock.print ntp_msg;sock.flush
data,_ = sock.recvfrom(960);
secondTime = Time.at(data.unpack("B319 B32 B32")[1].to_i(2) - 2208988800)
puts "NTP time after sleeping: #{secondTime}"

difference = secondTime - firstTime
puts "Difference in NTP times (should be at least #{ARGV[0].to_i} seconds): #{difference}"

if (difference >= ARGV[0].to_i)
	puts "Proceed!\n"
end

