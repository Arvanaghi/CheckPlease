#
#   Hostname checker, Ruby
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'socket'

if Socket.gethostname.downcase == ARGV.join(" ").downcase
	puts "Proceed!"
end