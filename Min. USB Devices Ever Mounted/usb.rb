#
#   Minimum number of USB devices ever mounted, Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'win32/registry'

minimumUSBHistory = 2;

if !ARGV.empty?
  minimumUSBHistory = ARGV[0].to_i
end

usbHistory = Win32::Registry::HKEY_LOCAL_MACHINE.open('SYSTEM\ControlSet001\Enum\USBSTOR').keys.length

if usbHistory >= minimumUSBHistory
  puts "Proceed!"
else
  puts "Number of USB devices ever mounted: " + usbHistory.to_s
end