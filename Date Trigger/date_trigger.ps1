#
#   Waits until a user-defined date to execute, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ($Args.count -eq 0) {
	Write-Output "You must provide a date in format mm/dd/yyyy."
	Exit
} else {
	$triggerDate = $($args[0])
}

while ((Get-Date) -lt (Get-Date $triggerDate)) {
	Start-Sleep -s 86340
}

Write-Output "Now that today is $triggerDate, we may proceed with malware execution!"