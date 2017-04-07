require 'socket'

if Socket.gethostname.downcase == ARGV.join(" ").downcase
	puts "Proceed!"
end