#
#   Minimum number of installed Windows Updates (default: 50), Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'win32ole'

minUpdates = 50
if ARGV.length > 0
  minUpdates = ARGV[0].to_i
end

numWindowsUpdates = (WIN32OLE.connect("winmgmts://").ExecQuery("SELECT * from win32_reliabilityRecords WHERE Sourcename = 'Microsoft-Windows-WindowsUpdateClient'")).count

if numWindowsUpdates > minUpdates
  puts "#{numWindowsUpdates} Windows Updates have been installed on the system, which is greater than the minimum you set of #{minUpdates}. Proceed!"
else
  puts "#{numWindowsUpdates} Windows Updates have been installed on the system, which is less than the minimum you set of #{minUpdates}. Do not proceed."
end