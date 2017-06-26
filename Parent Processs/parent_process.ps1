#
#   Ensures the name of the parent process that spawned the payload is as expected, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$expectedParentProc = "firefox"
if ($Args.count -eq 1) {
  $expectedParentProc = $($args[0])
}

$pPid = (Gwmi Win32_Process | ? {$_.ProcessID -eq $pid}).ParentProcessID
$actualParentProc = (Get-Process -ID $pPid).ProcessName

if ((Get-Process -ID $pPid).ProcessName | Select-String $expectedParentProc) {
  Write-Output "As expected, the parent process for this process is `"$actualParentProc`". Proceed!"  
} else {
  Write-Output "The parent process for this process is `"$actualParentProc`", not `"$expectedParentProc`" as you expected. Do not proceed."
}