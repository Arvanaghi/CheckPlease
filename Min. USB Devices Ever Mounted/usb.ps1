#
#   Minimum number of USB devices ever mounted, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ($($args[0]).count -eq 0) {
	$MinimumUSBHistory = 2
} else {
	$MinimumUSBHistory = $($args[0])
}

$usbCount = (Get-ChildItem HKLM:\SYSTEM\ControlSet001\Enum\USBSTOR).Name.Count

if ($usbCount -ge $MinimumUSBHistory) {
	Write-Output "Proceed!"
} else {
	Write-Output "Number of USB devices ever mounted: $usbCount"
}