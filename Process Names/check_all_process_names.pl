#
#   Checks all loaded process names, Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::OLE;

my @EvidenceOfSandbox;
my @sandboxProcesses = (q{vmsrvc}, q{tcpview}, q{wireshark}, q{visual basic}, q{fiddler}, q{vmware}, q{vbox}, q{process explorer}, q{autoit}, q{vboxtray}, q{vmtools}, q{vmrawdsk}, q{vmusbmouse}, q{vmvss}, q{vmscsi}, q{vmxnet}, q{vmx_svga}, q{vmmemctl}, q{df5serv}, q{vboxservice}, q{vmhgfs});

my $runningProcesses = Win32::OLE->GetObject("winmgmts:\\\\localhost\\root\\CIMV2")->ExecQuery("SELECT * FROM Win32_Process") or die;

foreach my $process (in $runningProcesses) {
	foreach $sandboxProcess (@sandboxProcesses) {
		if (index(lc($process->{Name}), lc($sandboxProcess)) != -1) {
			if (!(grep $_ eq $process->{Name}, @EvidenceOfSandbox)) {
				push(@EvidenceOfSandbox, $process->{Name});
			}
		} 
	}
}

if (!@EvidenceOfSandbox) {
	print "No sandbox-indicative process name was found running on the system. Proceed!\n";
} else {
	print "The following running processes suggest we are running in a sandbox. Do not proceed.\n", join("\n", @EvidenceOfSandbox), "\n";
}