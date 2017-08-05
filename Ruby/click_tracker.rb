#
#   Waits until N mouse clicks occur before executing (default: 10), Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'Win32API'

count = 0
minClicks = 10

getAsyncKeyState = Win32API.new("User32", "GetAsyncKeyState", ['i'], 'i')

if ARGV.length == 1
  minClicks = ARGV[0].to_i
end

while count < minClicks do
	new_state_left_click = getAsyncKeyState.call(0x1)
	new_state_right_click = getAsyncKeyState.call(0x2)

	if new_state_left_click % 2 == 1
		count += 1
	end
	if new_state_right_click % 2 == 1
		count += 1
	end
end

puts "Now that the user has clicked " + minClicks.to_s + " times, we may proceed with malware execution!"