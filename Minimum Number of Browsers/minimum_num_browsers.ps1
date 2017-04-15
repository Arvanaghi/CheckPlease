#
#   Minimum number of browsers, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$browserCount = 0

$browserKeys = 'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe', 'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\iexplore.exe', 'SOFTWARE\Mozilla'

ForEach ($browserKey in $browserKeys) {
	if (Test-Path ("HKLM:\" + $HKLM_Key)) {
		++$browserCount;
	}
}

if ($browserCount -ge 2) {
	Write-Output "Proceed!"
} else {
	Write-Output "Number of Browsers: $browserCount"
}