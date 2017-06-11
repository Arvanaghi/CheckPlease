#
#   Checks if time zone UTC, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$timezone = [System.TimeZone]::CurrentTimeZone.StandardName

if ($timezone -eq "Coordinated Universal Time") {
	Write-Output "The time zone is Coordinated Universal Time (UTC), do not proceed."
} else {
	Write-Output "The time zone is $timezone. Proceed!"
}