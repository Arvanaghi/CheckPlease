#
#   Checks username, Ruby
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ENV["USERNAME"].downcase == ARGV.join(" ").downcase
	puts "The user account running this script is " + ENV["USERNAME"].downcase + " as expected. Proceed!"
else
  puts "The user account running this script is " + ENV["USERNAME"].downcase + ", not " + ARGV.join(" ").downcase + " as expected. Do not proceed."
end