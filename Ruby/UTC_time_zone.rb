#
#   Checks if time zone is Coordinated Universal Time (UTC), Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if Time.now.getlocal.zone == "Coordinated Universal Time"
	puts "The time zone is Coordinated Universal Time (UTC), do not proceed."
else
	puts "The time zone is #{Time.now.getlocal.zone}. Proceed!"
end