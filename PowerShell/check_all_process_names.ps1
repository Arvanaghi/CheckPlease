#
#   Checks all loaded process names, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$EvidenceOfSandbox = New-Object System.Collections.ArrayList

$sandboxProcesses = "vmsrvc", "tcpview", "wireshark","visual basic", "fiddler", "vmware", "vbox", "process explorer", "autoit", "vboxtray", "vmtools", "vmrawdsk", "vmusbmouse", "vmvss", "vmscsi", "vmxnet", "vmx_svga", "vmmemctl", "df5serv", "vboxservice", "vmhgfs"

$RunningProcesses = Get-Process

ForEach ($RunningProcess in $RunningProcesses) {
	ForEach ($sandboxProcess in $sandboxProcesses) {
		if ($RunningProcess.ProcessName | Select-String $sandboxProcess) {
			if ($EvidenceOfSandbox -NotContains $RunningProcess.ProcessName) {
				[void]$EvidenceOfSandbox.Add($RunningProcess.ProcessName)
			}
		}
	}
}

if ($EvidenceOfSandbox.count -eq 0) {
	Write-Output "No sandbox-indicative process name was found running on the system. Proceed!"
} else {
	Write-Output "The following running processes suggest we are running in a sandbox. Do not proceed." 
	$EvidenceOfSandbox
}