#
#   Windows Running Process and Loaded DLL Checker, PowerShell
#		Ensures more than user-supplied N processes are running (defaults to 50)
#		Ensures no sandbox indicative process or DLL loaded
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ($($args[0]).count -eq 0) {
	$MinimumNumberOfProcesses = 50
} else {
	$MinimumNumberOfProcesses = $($args[0])
}

$EvidenceOfSandbox = New-Object System.Collections.ArrayList

$sandboxProcesses = "vmsrvc", "tcpview", "wireshark","visual basic", "fiddler", "vmware", "vbox", "process explorer", "autoit", "vboxtray", "vmtools", "vmrawdsk", "vmusbmouse", "vmvss", "vmscsi", "vmxnet", "vmx_svga", "vmmemctl", "df5serv", "vboxservice", "vmhgfs"
$sandboxDLLs = "sbiedll.dll","dbghelp.dll","api_log.dll","dir_watch.dll","pstorec.dll","vmcheck.dll","wpespy.dll"

$RunningProcesses = Get-Process
$LoadedDLLs = Get-Process | Select -Expand Modules -ErrorAction SilentlyContinue

ForEach ($RunningProcess in $RunningProcesses) {
	ForEach ($sandboxProcess in $sandboxProcesses) {
		if ($RunningProcess.ProcessName | Select-String $sandboxProcess) {
			if ($EvidenceOfSandbox -NotContains $RunningProcess.ProcessName) {
				[void]$EvidenceOfSandbox.Add($RunningProcess.ProcessName)
			}
		}
	}
}

ForEach ($LoadedDLL in $LoadedDLLs) {
	ForEach ($sandboxDLL in $sandboxDLLs) {
		if ($LoadedDLL.ModuleName | Select-String $sandboxDLL) {
			if ($EvidenceOfSandbox -NotContains $LoadedDLL.ModuleName) {
				[void]$EvidenceOfSandbox.Add($LoadedDLL.ModuleName)
			}
		}
	}
}

if ($EvidenceOfSandbox.count -eq 0 -and $RunningProcesses.count -ge $MinimumNumberOfProcesses) {
	Write-Output "Proceed!"
}