#
#   Filepath existence checker, Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

my @EvidenceOfSandbox;

my @FilePathsToCheck = (q{C:\Windows\Sysnative\Drivers\vmmouse.sys}, 
q{C:\Windows\Sysnative\Drivers\vm3dgl.dll}, q{C:\Windows\Sysnative\Drivers\vmdum.dll}, 
q{C:\Windows\Sysnative\Drivers\vm3dver.dll}, q{C:\Windows\Sysnative\Drivers\vmtray.dll},
q{C:\Windows\Sysnative\Drivers\vmci.sys}, q{C:\Windows\Sysnative\Drivers\vmusbmouse.sys},
q{C:\Windows\Sysnative\Drivers\vmx_svga.sys}, q{C:\Windows\Sysnative\Drivers\vmxnet.sys},
q{C:\Windows\Sysnative\Drivers\VMToolsHook.dll}, q{C:\Windows\Sysnative\Drivers\vmhgfs.dll},
q{C:\Windows\Sysnative\Drivers\vmmousever.dll}, q{C:\Windows\Sysnative\Drivers\vmGuestLib.dll},
q{C:\Windows\Sysnative\Drivers\VmGuestLibJava.dll}, q{C:\Windows\Sysnative\Drivers\vmscsi.sys},
q{C:\Windows\Sysnative\Drivers\VBoxMouse.sys}, q{C:\Windows\Sysnative\Drivers\VBoxGuest.sys},
q{C:\Windows\Sysnative\Drivers\VBoxSF.sys}, q{C:\Windows\Sysnative\Drivers\VBoxVideo.sys},
q{C:\Windows\Sysnative\vboxdisp.dll}, q{C:\Windows\Sysnative\vboxhook.dll},
q{C:\Windows\Sysnative\vboxmrxnp.dll}, q{C:\Windows\Sysnative\vboxogl.dll},
q{C:\Windows\Sysnative\vboxoglarrayspu.dll}, q{C:\Windows\Sysnative\vboxoglcrutil.dll},
q{C:\Windows\Sysnative\vboxoglerrorspu.dll}, q{C:\Windows\Sysnative\vboxoglfeedbackspu.dll},
q{C:\Windows\Sysnative\vboxoglpackspu.dll}, q{C:\Windows\Sysnative\vboxoglpassthroughspu.dll},
q{C:\Windows\Sysnative\vboxservice.exe}, q{C:\Windows\Sysnative\vboxtray.exe},
q{C:\Windows\Sysnative\VBoxControl.exe});

foreach $FilePath (@FilePathsToCheck) {
	if (-e $FilePath) {
		push(@EvidenceOfSandbox, $FilePath);
	}
}

if (!@EvidenceOfSandbox) {
	print "No files exist on disk that suggest we are running in a sandbox. Proceed!\n";
} else {
	print "The following files on disk suggest we are running in a sandbox. Do not proceed.\n";
	print join(", ", @EvidenceOfSandbox), "\n";
}
