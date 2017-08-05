#
#   Checks all DLL names loaded by each process, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$EvidenceOfSandbox = New-Object System.Collections.ArrayList
$sandboxDLLs = "sbiedll.dll","dbghelp.dll","api_log.dll","dir_watch.dll","pstorec.dll","vmcheck.dll","wpespy.dll"

$LoadedDLLs = Get-Process | Select -Expand Modules -ErrorAction SilentlyContinue

ForEach ($LoadedDLL in $LoadedDLLs) {
	ForEach ($sandboxDLL in $sandboxDLLs) {
		if ($LoadedDLL.ModuleName | Select-String $sandboxDLL) {
			if ($EvidenceOfSandbox -NotContains $LoadedDLL.ModuleName) {
				[void]$EvidenceOfSandbox.Add($LoadedDLL.ModuleName)
			}
		}
	}
}

if ($EvidenceOfSandbox) {
	Write-Output "The following sandbox-indicative DLLs were discovered loaded in processes running on the system. Do not proceed."
	$EvidenceOfSandbox
} else {
	Write-Output "No sandbox-indicative DLLs were discovered loaded in any accessible running process. Proceed!"
}