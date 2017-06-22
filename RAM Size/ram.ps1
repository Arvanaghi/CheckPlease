#
#   Minimum RAM size checker, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ((Get-Ciminstance Win32_OperatingSystem).TotalVisibleMemorySize/1048576 -gt 1) {
	Write-Output "The RAM of this host is at least 1 GB in size. Proceed!"
} else {
	Write-Output "Less than 1 GB of RAM exists on this system. Do not proceed."
}