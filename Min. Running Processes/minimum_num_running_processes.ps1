#
#   Windows Minimum Number of Running Processes, PowerShell
#   Ensures at least N processes running on the system (defaults to 50)
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ($($args[0]).count -eq 0) {
	$MinimumNumberOfProcesses = 50
} else {
	$MinimumNumberOfProcesses = $($args[0])
}

$RunningProcesses = Get-Process

if ($RunningProcesses.count -ge $MinimumNumberOfProcesses) {
	Write-Output "Proceed!"
}