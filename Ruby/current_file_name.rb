#
#   Ensures the current file name is as expected, Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

expectedName = ""

if ARGV.length != 1
  puts "You must provide a file name to check for."
    exit(1)
else
  expectedName = ARGV[0]
end

if File.basename(__FILE__) == expectedName
  puts "The file name is #{expectedName} as expected. Proceed!"
else
  puts "The file name is #{File.basename(__FILE__)}, not #{expectedName} as expected. Do not proceed."
end
