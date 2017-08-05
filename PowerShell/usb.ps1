#
#   Minimum number of USB devices ever mounted, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ($Args.count -eq 0) {
	$MinimumUSBHistory = 2
} else {
	$MinimumUSBHistory = $($args[0])
}

$usbCount = (Get-ChildItem HKLM:\SYSTEM\ControlSet001\Enum\USBSTOR).Name.Count

if ($usbCount -ge $MinimumUSBHistory) {
	Write-Output "$usbCount USB devices have ever been mounted. Proceed!"
} else {
	Write-Output "Only $usbCount USB devices have ever been mounted. Do not proceed."
}