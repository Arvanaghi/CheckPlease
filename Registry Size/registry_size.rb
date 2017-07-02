#
#   Minimum Registry size checker (default: 55 MB), Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'win32ole'

minRegSizeMB = 55 
if ARGV.length > 0
  minRegSizeMB = ARGV[0].to_i
end

regObjects = WIN32OLE.connect("winmgmts://").ExecQuery("SELECT CurrentSize from Win32_Registry")

for regObject in regObjects do
  if regObject.CurrentSize > minRegSizeMB
      puts "The size of the Registry on this host is #{regObject.CurrentSize} MB, which is greater than the minimum you set of #{minRegSizeMB} MB. Proceed!"
    else
      puts "The size of the Registry on this host is #{regObject.CurrentSize} MB, which is less than the minimum you set of #{minRegSizeMB} MB. Do not proceed."
    end
end