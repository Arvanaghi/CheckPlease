#
#   Minimum number of installed Windows Updates (default: 50), PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$minUpdates = 50
if ($Args.count -gt 0) {
    $minUpdates = $($args[0])
} 

$numWindowsUpdates = (GWMI -Class win32_reliabilityRecords -Filter "Sourcename = 'Microsoft-Windows-WindowsUpdateClient'").Count

if ($numWindowsUpdates -gt $minUpdates) {
  Write-Output "$numWindowsUpdates Windows Updates have been installed on the system, which is greater than the minimum you set of $minUpdates. Proceed!"
} else {
  Write-Output "$numWindowsUpdates Windows Updates have been installed on the system, which is less than the minimum you set of $minUpdates. Do not proceed."
}
