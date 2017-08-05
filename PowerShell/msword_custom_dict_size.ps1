#
#   Minimum number of words added to dictionary in Microsoft Word (default: 1), PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

if ($Args.count -eq 0) {
  $minWordEntries = 1
} else {
  $minWordEntries = $($args[0])
}

$customWordEntries = (Get-Content $env:appdata\Microsoft\UProof\CUSTOM.DIC | Measure-Object).Count

if ($customWordEntries -gt $minWordEntries) {
	Write-Output "$customWordEntries custom words have been added to the Microsoft Word dictionary, which is greater than the minimum you set of $minWordEntries. Proceed!"
} else {
	Write-Output "$customWordEntries custom words have been added to the Microsoft Word dictionary, which is less than the minimum you set of $minWordEntries. Do not proceed."
}
