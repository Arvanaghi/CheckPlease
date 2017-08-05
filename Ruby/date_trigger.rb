#
#   Waits until a user-defined date to execute, Ruby
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'date'

if ARGV.length != 1
	puts "You must provide a date in format mm/dd/yyyy."
	exit(1)
end

triggerDate = Date.strptime(ARGV[0], "%m/%d/%Y").to_date

while (Time.now.to_date < triggerDate)
	sleep(86340)
end

puts "Now that today is " + Time.now.to_date.strftime("%m/%d/%Y").to_s + ", we may proceed with malware execution!"