#
#   Checks if cursor is in same position after sleeping N seconds (default: 20 min), Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require "Win32API"

secs = 1200
if ARGV.length == 1
	secs = ARGV[0].to_i
end

def getPoint()
	getCursorPos = Win32API.new("user32", "GetCursorPos", ['P'], 'L')
	pt = "\0" * 8
	getCursorPos.call(pt)
	return pt.unpack('LL')
end

firstPoint = getPoint()
puts "x: " + firstPoint[0].to_s + ", y: " + firstPoint[1].to_s

sleep(secs)

secondPoint = getPoint()
puts "x: " + secondPoint[0].to_s + ", y: " + secondPoint[1].to_s

if firstPoint[0] - secondPoint[0] && firstPoint[1] - secondPoint[1] == 0
	puts "The cursor has not moved in the last " + secs.to_s + " seconds. Do not proceed."
else
	puts "The cursor is not in the same position as it was " + secs.to_s + " seconds ago. Proceed!"
end