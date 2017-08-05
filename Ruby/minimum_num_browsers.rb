#
#   Minimum number of browsers, Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'win32/registry'

browserCount = 0

browserKeys = ['SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe', 'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\iexplore.exe', 'SOFTWARE\Mozilla']

for index in 0 ... browserKeys.size
  begin
    reg_access = Win32::Registry::KEY_READ | 0x100
    Win32::Registry::HKEY_LOCAL_MACHINE.open(browserKeys[index], reg_access) { browserCount += 1 }
  rescue
  end
end

if browserCount >= 2
  puts "Proceed!"
else
  puts "Number of Browsers: " + browserCount.to_s
end