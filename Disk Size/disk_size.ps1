#
#   Minimum disk size checker, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$diskSize = (GWMI -Class Win32_LogicalDisk | Measure-Object -Sum Size | Select-Object -Expand Sum) / 1073741824 

if ($diskSize -gt 50) {
  Write-Output "The disk size of this host is at least 50 GB in size. Proceed!"
} else {
  Write-Output "The disk size of this host is less than 50 GB. Do not proceed."
}