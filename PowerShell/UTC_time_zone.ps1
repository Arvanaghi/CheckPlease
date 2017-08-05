#
#   Checks if time zone is Coordinated Universal Time (UTC), PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$standardTimezone = [System.TimeZone]::CurrentTimeZone.StandardName
$daylightTimezone = [System.TimeZone]::CurrentTimeZone.DaylightName

if ($standardTimezone -eq "Coordinated Universal Time" -or $daylightTimezone -eq "Coordinated Universal Time") {
	Write-Output "The time zone is Coordinated Universal Time (UTC), do not proceed."
} else {
	Write-Output "The time zone is $standardTimezone. Proceed!"
}