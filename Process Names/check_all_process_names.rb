#
#   Checks all loaded process names, Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'win32ole'

EvidenceOfSandbox = Array.new
sandboxProcesses = ['vmsrvc', 'tcpview', 'wireshark', 'visual basic', 'fiddler', 'vmware', 'vbox', 'process explorer', 'autoit', 'vboxtray', 'vmtools', 'vmrawdsk', 'vmusbmouse', 'vmvss', 'vmscsi', 'vmxnet', 'vmx_svga', 'vmmemctl', 'df5serv', 'vboxservice', 'vmhgfs']

runningProcesses = WIN32OLE.connect("winmgmts://").ExecQuery("SELECT * FROM Win32_Process")

for process in runningProcesses do
	for sandboxProcess in sandboxProcesses do
		if process.Name.downcase().include? sandboxProcess
			EvidenceOfSandbox.push(process.Name)
		end
	end
end

if EvidenceOfSandbox.empty?
	puts "No sandbox-indicative process name was found running on the system. Proceed!"
else
	puts "The following running processes suggest we are running in a sandbox. Do not proceed.\n" + EvidenceOfSandbox.join(", ")
end