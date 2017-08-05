#
#   Prompts user with dialog box and waits for response before executing, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$dialogBoxTitle = "CheckPlease by @arvanaghi and @ChrisTruncer"
$dialogBoxMessage = "This is a sample dialog box to ensure user activity!"

if ($Args.count -eq 2) {
	$dialogBoxTitle = $($args[0])
	$dialogBoxMessage = $($args[1])
}

$messageBox = New-Object -COMObject WScript.Shell
[void]$messageBox.Popup($dialogBoxMessage,0,$dialogBoxTitle,0)

Write-Output "Now that the user has clicked `"OK`" or closed the dialog box, we will proceed with malware execution!"