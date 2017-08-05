#
#   Filepath existence checker, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$EvidenceOfSandbox = New-Object System.Collections.ArrayList

$FilePathsToCheck = 'C:\windows\System32\Drivers\Vmmouse.sys', 
'C:\windows\System32\Drivers\vm3dgl.dll', 'C:\windows\System32\Drivers\vmdum.dll', 
'C:\windows\System32\Drivers\vm3dver.dll', 'C:\windows\System32\Drivers\vmtray.dll',
'C:\windows\System32\Drivers\vmci.sys', 'C:\windows\System32\Drivers\vmusbmouse.sys',
'C:\windows\system32\Drivers\vmx_svga.sys', 'C:\windows\system32\Drivers\vmxnet.sys',
'C:\windows\System32\Drivers\VMToolsHook.dll', 'C:\windows\System32\Drivers\vmhgfs.dll',
'C:\windows\System32\Drivers\vmmousever.dll', 'C:\windows\System32\Drivers\vmGuestLib.dll',
'C:\windows\System32\Drivers\VmGuestLibJava.dll', 'C:\windows\System32\Drivers\vmscsi.sys',
'C:\windows\System32\Drivers\VBoxMouse.sys', 'C:\windows\System32\Drivers\VBoxGuest.sys',
'C:\windows\System32\Drivers\VBoxSF.sys', 'C:\windows\System32\Drivers\VBoxVideo.sys',
'C:\windows\System32\vboxdisp.dll', 'C:\windows\System32\vboxhook.dll',
'C:\windows\System32\vboxmrxnp.dll', 'C:\windows\System32\vboxogl.dll',
'C:\windows\System32\vboxoglarrayspu.dll', 'C:\windows\System32\vboxoglcrutil.dll',
'C:\windows\System32\vboxoglerrorspu.dll', 'C:\windows\System32\vboxoglfeedbackspu.dll',
'C:\windows\System32\vboxoglpackspu.dll', 'C:\windows\System32\vboxoglpassthroughspu.dll',
'C:\windows\System32\vboxservice.exe', 'C:\windows\System32\vboxtray.exe',
'C:\windows\System32\VBoxControl.exe'

ForEach ($FilePath in $FilePathsToCheck) {
	if (Test-Path $FilePath) {
		[void]$EvidenceOfSandbox.Add($FilePath)
	}
}

if ($EvidenceOfSandbox.count -eq 0) {
	Write-Output "No files exist on disk that suggest we are running in a sandbox. Proceed!"
} else {
	Write-Output "The following files on disk suggest we are running in a sandbox. Do not proceed."
	$EvidenceOfSandbox
}