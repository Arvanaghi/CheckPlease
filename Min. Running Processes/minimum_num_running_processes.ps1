#
#   Ensures there are more than N processes currently running on the system (default: 50), PowerShell
#   Ensures at least N processes running on the system (defaults to 50)
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ($($args[0]).count -eq 0) {
	$minNumProcesses = 50
} else {
	$minNumProcesses = $($args[0])
}

$runningProcesses = (Get-Process).count

if ($runningProcesses -ge $minNumProcesses) {
	Write-Output "There are $runningProcesses processes running on the system, which satisfies the minimum you set of $minNumProcesses. Proceed!"
} else {
	Write-Output "Only $runningProcesses processes are running on the system, which is less than the minimum you set of $minNumProcesses. Do not proceed."
}