#
#   Prompts user with dialog box and waits for response before executing, Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require "Win32API"

dialogBoxTitle = "CheckPlease by @arvanaghi and @ChrisTruncer";
dialogBoxMessage = "This is a sample dialog box to ensure user activity!"

if ARGV.length == 2
  dialogBoxTitle = ARGV[0]
  dialogBoxMessage = ARGV[1]
end

winapi = Win32API.new('user32', 'MessageBox',['L', 'P', 'P', 'L'],'I')
winapi.call(0,dialogBoxMessage,dialogBoxTitle,0)

puts "Now that the user has clicked \"OK\" or closed the dialog box, we will proceed with malware execution!"