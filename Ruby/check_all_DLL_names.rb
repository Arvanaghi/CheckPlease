#
#   Checks all DLL names loaded by each process, Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'win32ole'

EvidenceOfSandbox = Array.new
sandboxDLLs = ["sbiedll.dll","dbghelp.dll","api_log.dll","dir_watch.dll","pstorec.dll","vmcheck.dll","wpespy.dll"]

runningProcesses = WIN32OLE.connect("winmgmts://").ExecQuery("SELECT * FROM CIM_ProcessExecutable")

for process in runningProcesses do
	for sandboxDLL in sandboxDLLs do
		if process.Antecedent.downcase().include? sandboxDLL
			EvidenceOfSandbox.push(process.Antecedent) unless EvidenceOfSandbox.include? process.Antecedent
		end
	end
end

if EvidenceOfSandbox.empty?
	puts "No sandbox-indicative DLLs were discovered loaded in any accessible running process. Proceed!"
else
	puts "The following sandbox-indicative DLLs were discovered loaded in processes running on the system. Do not proceed\n" + EvidenceOfSandbox.join(", ")
end