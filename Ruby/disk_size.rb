#
#   Minimum disk size checker (default: 50 GB), Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'win32api'

minDiskSizeGB = 50

if ARGV.length > 0
  minDiskSizeGB = ARGV[0].to_i
end

GetDiskFreeSpaceEx = Win32API.new("kernel32", "GetDiskFreeSpaceEx", ['P','P','P','P'], 'I')

diskSizeBytes = [0].pack("Q"); freeBytesAvail = [0].pack("Q"); totalFreeBytes = [0].pack("Q")
GetDiskFreeSpaceEx.call("C:", freeBytesAvail, diskSizeBytes, totalFreeBytes)

diskSizeGB = diskSizeBytes.unpack("Q").first / 1073741824.0

if diskSizeGB > minDiskSizeGB
  puts "The disk size of this host is " + diskSizeGB.to_s + " GB, which is greater than the minimum you set of " + minDiskSizeGB.to_s + " GB. Proceed!"
else
  puts "The disk size of this host is " + diskSizeGB.to_s + " GB, which is less than the minimum you set of " + minDiskSizeGB.to_s + " GB. Do not proceed."
end