#
#   Minimum Registry size checker (default: 55 MB), PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ($Args.count -eq 0) {
  $minRegSizeMB = 55
} else {
  $minRegSizeMB = $($args[0])
}

$regSize = GWMI -Class Win32_Registry | Select-Object -Expand CurrentSize

if ($regSize -gt $minRegSizeMB) {
  Write-Output "The size of the Registry on this host is $regSize MB, which is greater than the minimum you set of $minRegSizeMB MB. Proceed!"
} else {
  Write-Output "The size of the Registry on this host is $regSize MB, which is less than the minimum you set of $minRegSizeMB MB. Do not proceed."
}