#
#   Minimum number of browsers, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$browserCount = 0

$browserKeys = 'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe', 'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\iexplore.exe', 'SOFTWARE\Mozilla'

ForEach ($browserKey in $browserKeys) {
  if (Test-Path ("HKLM:\$browserKey")) {
    ++$browserCount;
  }
}

if ($browserCount -ge 2) {
  Write-Output "There are at least 2 web browsers present on the system. Proceed!"
} else {
  Write-Output "Less than 2 web browsers exist on the system, do not proceed (found: $browserCount)."
}