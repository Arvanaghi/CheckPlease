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

def getCoords()
  getCursorPos = Win32API.new("user32", "GetCursorPos", ['P'], 'L')
  coordinates = "\0" * 8
  getCursorPos.call(coordinates)
  return coordinates.unpack('LL')
end

firstCoords = getCoords()
puts "x: " + firstCoords[0].to_s + ", y: " + firstCoords[1].to_s

sleep(secs)

secondCoords = getCoords()
puts "x: " + secondCoords[0].to_s + ", y: " + secondCoords[1].to_s

if firstCoords[0] - secondCoords[0] && firstCoords[1] - secondCoords[1] == 0
  puts "The cursor has not moved in the last " + secs.to_s + " seconds. Do not proceed."
else
  puts "The cursor is not in the same position as it was " + secs.to_s + " seconds ago. Proceed!"
end