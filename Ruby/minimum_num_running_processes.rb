#
#   Ensures there are more than N processes currently running on the system (default: 50), Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'win32ole'

minNumberProcesses = 50
if ARGV.length == 1
  minNumberProcesses = ARGV[0].to_i
end

runningProcesses = WIN32OLE.connect("winmgmts://").ExecQuery("SELECT * FROM Win32_Process").count

if runningProcesses >= minNumberProcesses
	puts "There are #{runningProcesses} processes running on the system, which satisfies the minimum you set of #{minNumberProcesses}. Proceed!"
else
	puts "Only #{runningProcesses} processes are running on the system, which is less than the minimum you set of #{minNumberProcesses}. Do not proceed."
end