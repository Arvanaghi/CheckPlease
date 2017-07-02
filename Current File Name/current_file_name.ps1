#
#   Ensures the current file name is as expected, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ($Args.count -ne 1) {
    Write-Output "You must provide a file name to check for."
    exit(1)
} else {
  $expectedName = $($args[0])
}

$actualName = $MyInvocation.MyCommand.Name

if ($actualName -eq $expectedName) {
  Write-Output "The file name is $expectedName as expected. Proceed!"
} else {
  Write-Output "The file name is $actualName, not $expectedName as expected. Do not proceed."
}