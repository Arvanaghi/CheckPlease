#
#   Filepath existence checker, Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

EvidenceOfSandbox = Array.new

FilePathsToCheck = ['C:\Windows\Sysnative\Drivers\vmmouse.sys', 
'C:\Windows\Sysnative\Drivers\vm3dgl.dll', 'C:\Windows\Sysnative\Drivers\vmdum.dll', 
'C:\Windows\Sysnative\Drivers\vm3dver.dll', 'C:\Windows\Sysnative\Drivers\vmtray.dll',
'C:\Windows\Sysnative\Drivers\vmci.sys', 'C:\Windows\Sysnative\Drivers\vmusbmouse.sys',
'C:\Windows\Sysnative\Drivers\vmx_svga.sys', 'C:\Windows\Sysnative\Drivers\vmxnet.sys',
'C:\Windows\Sysnative\Drivers\VMToolsHook.dll', 'C:\Windows\Sysnative\Drivers\vmhgfs.dll',
'C:\Windows\Sysnative\Drivers\vmmousever.dll', 'C:\Windows\Sysnative\Drivers\vmGuestLib.dll',
'C:\Windows\Sysnative\Drivers\VmGuestLibJava.dll', 'C:\Windows\Sysnative\Drivers\vmscsi.sys',
'C:\Windows\Sysnative\Drivers\VBoxMouse.sys', 'C:\Windows\Sysnative\Drivers\VBoxGuest.sys',
'C:\Windows\Sysnative\Drivers\VBoxSF.sys', 'C:\Windows\Sysnative\Drivers\VBoxVideo.sys',
'C:\Windows\Sysnative\vboxdisp.dll', 'C:\Windows\Sysnative\vboxhook.dll',
'C:\Windows\Sysnative\vboxmrxnp.dll', 'C:\Windows\Sysnative\vboxogl.dll',
'C:\Windows\Sysnative\vboxoglarrayspu.dll', 'C:\Windows\Sysnative\vboxoglcrutil.dll',
'C:\Windows\Sysnative\vboxoglerrorspu.dll', 'C:\Windows\Sysnative\vboxoglfeedbackspu.dll',
'C:\Windows\Sysnative\vboxoglpackspu.dll', 'C:\Windows\Sysnative\vboxoglpassthroughspu.dll',
'C:\Windows\Sysnative\vboxservice.exe', 'C:\Windows\Sysnative\vboxtray.exe',
'C:\Windows\Sysnative\VBoxControl.exe']

for index in 0 ... FilePathsToCheck.size
	if File.exist?(FilePathsToCheck[index])
		EvidenceOfSandbox.push(FilePathsToCheck[index])
	end
end

if EvidenceOfSandbox.empty?
	puts "No files exist on disk that suggest we are running in a sandbox. Proceed!"
else
	puts "The following files on disk suggest we are running in a sandbox. Do not proceed."
	puts EvidenceOfSandbox.join(' ')
end