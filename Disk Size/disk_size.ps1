#
#   Minimum disk size checker (default: 50 GB), PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ($Args.count -eq 0) {
  $minDiskSizeGB = 50
} else {
  $minDiskSizeGB = $($args[0])
}

$diskSize = (GWMI -Class Win32_LogicalDisk | Measure-Object -Sum Size | Select-Object -Expand Sum) / 1073741824 

if ($diskSize -gt $minDiskSizeGB) {
  Write-Output "The disk size of this host is $diskSize GB, which is greater than the minimum you set of $minDiskSizeGB GB. Proceed!"
} else {
  Write-Output "The disk size of this host is $diskSize GB, which is less than the minimum you set of $minDiskSizeGB GB. Do not proceed."
}