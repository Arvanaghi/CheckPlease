#
#   Ensures the name of the parent process that spawned the payload is as expected, Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'win32ole'

expectedParentProc = "firefox"
if ARGV.length == 1
  expectedParentProc = ARGV[0]
end

processes = WIN32OLE.connect("winmgmts://").ExecQuery("SELECT CommandLine from Win32_Process WHERE ProcessID = " + Process.ppid.to_s)

for process in processes do
  if process.CommandLine.downcase().include? expectedParentProc
      puts "As expected, the parent process for this process is #{process.CommandLine}. Proceed!"
    else
      puts "The parent process for this process is \"#{process.commandline}\", not \"#{expectedParentProc}\" as you expected. Do not proceed."
    end
end