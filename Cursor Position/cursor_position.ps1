#
#	 Checks if cursor is in same position after sleeping N seconds (default: 20 min), PowerShell
#	 Module written by Brandon Arvanaghi
#	 Website: arvanaghi.com 
#	 Twitter: @arvanaghi
#

Add-Type -AssemblyName System.Windows.Forms

$secs = 1200
if ($Args.count -eq 1) {
	$secs = $($args[0])
} 

Add-Type -AssemblyName System.Windows.Forms

$x1 = [System.Windows.Forms.Cursor]::Position.X
$y1 = [System.Windows.Forms.Cursor]::Position.Y
Write-Output "The coordinates of the cursor are currently x: $x1, y: $y1"

Start-Sleep $secs

$x2 = [System.Windows.Forms.Cursor]::Position.X
$y2 = [System.Windows.Forms.Cursor]::Position.Y
Write-Output "After sleeping $secs seconds, the coordinates of the cursor are now x: $x2, y: $y2"

if ($x1 - $x2 -eq 0 -and $y1 - $y2 -eq 0) {
	Write-Output "The cursor has not moved in the last $secs seconds. Do not proceed."
} else {
	Write-Output "The cursor is not in the same position as it was $secs seconds ago. Proceed!"
}