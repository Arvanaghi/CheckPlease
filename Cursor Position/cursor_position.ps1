#
#   Checks if cursor is in same position after sleeping N seconds (default: 20 min), PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$secs = 1200
if ($Args.count -eq 1) {
    $secs = $($args[0])
} 

$getCursorPosProto = @'
[DllImport("user32.dll")]
public static extern bool GetCursorPos(out System.Drawing.Point point);
'@

Add-Type -MemberDefinition $getCursorPosProto -Namespace MouseTracker -Name Pos

$point = New-Object System.Drawing.Point
[void][MouseTracker.Pos]::GetCursorPos([ref]$point)
Write-Output "x: $($point.x), y: $($point.y)"

Start-Sleep $secs

$point2 = New-Object System.Drawing.Point
[void][MouseTracker.Pos]::GetCursorPos([ref]$point2)
Write-Output "x: $($point2.x), y: $($point2.y)"

if ($point.x - $point2.x -eq 0 -and $point.y - $point2.y -eq 0) {
    Write-Output "The cursor has not moved in the last $secs seconds. Do not proceed."
} else {
    Write-Output "The cursor is not in the same position as it was $secs seconds ago. Proceed!"
}