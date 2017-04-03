#
#   Windows Running Process and Loaded DLL Checker, Python
#		Ensures more than user-supplied N processes are running (defaults to 50)
#		Ensures no sandbox indicative process or DLL loaded
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import subprocess

EvidenceOfSandbox = []
sandboxProcesses = "vmsrvc", "tcpview", "wireshark", "visual basic", "fiddler", "vmware", "vbox", "process explorer", "autoit", "vboxtray", "vmtools", "vmrawdsk", "vmusbmouse", "vmvss", "vmscsi", "vmxnet", "vmx_svga", "vmmemctl", "df5serv", "vboxservice", "vmhgfs"

cmd = 'WMIC PROCESS get Caption'
proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, universal_newlines=True)

for process in proc.stdout:
	for sandboxProcess in sandboxProcesses:
		if sandboxProcess in str(process):
			EvidenceOfSandbox += process.split()

if not EvidenceOfSandbox:
	print("Proceed!")
else:
	print(EvidenceOfSandbox)