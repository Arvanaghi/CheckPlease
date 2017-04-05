#
#   Filepath Existence Checker, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import os.path

EvidenceOfSandbox = []

FilePathsToCheck = [r'C:\windows\System32\Drivers\Vmmouse.sys', 
r'C:\windows\System32\Drivers\vm3dgl.dll', r'C:\windows\System32\Drivers\vmdum.dll', 
r'C:\windows\System32\Drivers\vm3dver.dll', r'C:\windows\System32\Drivers\vmtray.dll',
r'C:\windows\System32\Drivers\vmci.sys', r'C:\windows\System32\Drivers\vmusbmouse.sys',
r'C:\windows\system32\Drivers\vmx_svga.sys', r'C:\windows\system32\Drivers\vmxnet.sys',
r'C:\windows\System32\Drivers\VMToolsHook.dll', r'C:\windows\System32\Drivers\vmhgfs.dll',
r'C:\windows\System32\Drivers\vmmousever.dll', r'C:\windows\System32\Drivers\vmGuestLib.dll',
r'C:\windows\System32\Drivers\VmGuestLibJava.dll', r'C:\windows\System32\Drivers\vmscsi.sys',
r'C:\windows\System32\Drivers\VBoxMouse.sys', r'C:\windows\System32\Drivers\VBoxGuest.sys',
r'C:\windows\System32\Drivers\VBoxSF.sys', r'C:\windows\System32\Drivers\VBoxVideo.sys',
r'C:\windows\System32\vboxdisp.dll', r'C:\windows\System32\vboxhook.dll',
r'C:\windows\System32\vboxmrxnp.dll', r'C:\windows\System32\vboxogl.dll',
r'C:\windows\System32\vboxoglarrayspu.dll', r'C:\windows\System32\vboxoglcrutil.dll',
r'C:\windows\System32\vboxoglerrorspu.dll', r'C:\windows\System32\vboxoglfeedbackspu.dll',
r'C:\windows\System32\vboxoglpackspu.dll', r'C:\windows\System32\vboxoglpassthroughspu.dll',
r'C:\windows\System32\vboxservice.exe', r'C:\windows\System32\vboxtray.exe',
r'C:\windows\System32\VBoxControl.exe']

for FilePath in FilePathsToCheck:
	print(FilePath)
	if os.path.isfile(FilePath):
		EvidenceOfSandbox.append(FilePath)

if not EvidenceOfSandbox:
	print("Proceed!")
else:
	print(EvidenceOfSandbox)