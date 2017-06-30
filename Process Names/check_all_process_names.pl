#
#   Checks all loaded process names, Perl
#   Module written by Brandon Arvanaghi 
#   Logic of extracting pids and process names from `tasklist` taken from https://stackoverflow.com/questions/16191112/windows-running-processes-list-perl
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

my @EvidenceOfSandbox;
my @sandboxProcesses = (q{vmsrvc}, q{tcpview}, q{wireshark}, q{visual basic}, q{fiddler}, q{vmware}, q{vbox}, q{process explorer}, q{autoit}, q{vboxtray}, q{vmtools}, q{vmrawdsk}, q{vmusbmouse}, q{vmvss}, q{vmscsi}, q{vmxnet}, q{vmx_svga}, q{vmmemctl}, q{df5serv}, q{vboxservice}, q{vmhgfs});

my @procs = `tasklist`;

my $pid_pos;
if ($procs[2] =~ /^=+/) { $pid_pos = $+[0]+1; } else { die; }

my %pids;
for (@procs[3 .. $#procs]) {
	my $name = substr $_,0,$pid_pos;
	$name =~s/^\s+|\s+$//g;

	if (substr($_,$pid_pos) =~ /^\s*(\d+)/) {
		$pids{$1} = $name;	
	}
}

while(my($pid, $processName) = each %pids) {
	foreach $sandboxProcess (@sandboxProcesses) {
		if (index($processName, $sandboxProcess) != -1) {
			push(@EvidenceOfSandbox, $processName);
		} 
	}
}

if (!@EvidenceOfSandbox) {
	print "No sandbox-indicative process name was found running on the system. Proceed!\n";
} else {
	print "The following running processes suggest we are running in a sandbox. Do not proceed.\n", join("\n", @EvidenceOfSandbox), "\n";
}