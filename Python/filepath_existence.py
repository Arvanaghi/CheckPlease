#
#   Filepath existence checker, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import os

EvidenceOfSandbox = []

FilePathsToCheck = [r'C:\windows\Sysnative\Drivers\Vmmouse.sys', 
r'C:\windows\Sysnative\Drivers\vm3dgl.dll', r'C:\windows\Sysnative\Drivers\vmdum.dll', 
r'C:\windows\Sysnative\Drivers\vm3dver.dll', r'C:\windows\Sysnative\Drivers\vmtray.dll',
r'C:\windows\Sysnative\Drivers\vmci.sys', r'C:\windows\Sysnative\Drivers\vmusbmouse.sys',
r'C:\windows\Sysnative\Drivers\vmx_svga.sys', r'C:\windows\Sysnative\Drivers\vmxnet.sys',
r'C:\windows\Sysnative\Drivers\VMToolsHook.dll', r'C:\windows\Sysnative\Drivers\vmhgfs.dll',
r'C:\windows\Sysnative\Drivers\vmmousever.dll', r'C:\windows\Sysnative\Drivers\vmGuestLib.dll',
r'C:\windows\Sysnative\Drivers\VmGuestLibJava.dll', r'C:\windows\Sysnative\Drivers\vmscsi.sys',
r'C:\windows\Sysnative\Drivers\VBoxMouse.sys', r'C:\windows\Sysnative\Drivers\VBoxGuest.sys',
r'C:\windows\Sysnative\Drivers\VBoxSF.sys', r'C:\windows\Sysnative\Drivers\VBoxVideo.sys',
r'C:\windows\Sysnative\vboxdisp.dll', r'C:\windows\Sysnative\vboxhook.dll',
r'C:\windows\Sysnative\vboxmrxnp.dll', r'C:\windows\Sysnative\vboxogl.dll',
r'C:\windows\Sysnative\vboxoglarrayspu.dll', r'C:\windows\Sysnative\vboxoglcrutil.dll',
r'C:\windows\Sysnative\vboxoglerrorspu.dll', r'C:\windows\Sysnative\vboxoglfeedbackspu.dll',
r'C:\windows\Sysnative\vboxoglpackspu.dll', r'C:\windows\Sysnative\vboxoglpassthroughspu.dll',
r'C:\windows\Sysnative\vboxservice.exe', r'C:\windows\Sysnative\vboxtray.exe',
r'C:\windows\Sysnative\VBoxControl.exe']

for FilePath in FilePathsToCheck:
	if os.path.isfile(FilePath):
		EvidenceOfSandbox.append(FilePath)

if EvidenceOfSandbox:
	print("The following files on disk suggest we are running in a sandbox. Do not proceed.\n{0}".format(EvidenceOfSandbox))
else:
	print("No files exist on disk that suggest we are running in a sandbox. Proceed!")
	