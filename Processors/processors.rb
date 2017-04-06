require 'win32ole'

if (WIN32OLE.connect("winmgmts://").ExecQuery("SELECT NumberOfCores FROM Win32_Processor").to_enum.first.NumberOfCores >= ARGV[0].to_i)
	puts "Proceed!"
end