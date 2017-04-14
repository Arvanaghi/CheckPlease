#
#   MAC address checker, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$EvidenceOfSandbox = New-Object System.Collections.ArrayList

$BadMACAddresses = '00:0C:29', '00:1C:14', '00:50:56', '00:05:69', '08:00:27'
$MACAddresses = Get-WmiObject Win32_NetworkAdapterConfiguration | Select -ExpandProperty MACAddress

ForEach ($MACAddress in $MACAddresses) {
	ForEach ($BadMACAddress in $BadMACAddresses) {
		if ($MACAddress | Select-String $BadMACAddress) {
			[void]$EvidenceOfSandbox.Add($MACAddress)
		}
	}
}

if ($EvidenceOfSandbox.count -eq 0) {
	Write-Output "Proceed!"
} else {
	$EvidenceOfSandbox
}