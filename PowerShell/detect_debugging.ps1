#
#   Checks if process is currently being debugged, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if (Test-Path Variable:PSDebugContext) {
	Write-Output "A debugger is present, do not proceed."
} else {
	Write-Output "No debugger is present. Proceed!"
}