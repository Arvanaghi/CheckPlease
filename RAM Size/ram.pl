#
#   Minimum number of browsers, Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::OLE qw(EVENTS HRESULT in);

my $wmiCIM = Win32::OLE->GetObject("WINMGMTS://./root/CIMv2");

my $RAM_running_total = 0;
foreach my $subMem (in($wmiCIM->InstancesOf('Win32_PhysicalMemory'))) {
    $RAM_running_total += $subMem->{Capacity};
}

if ($RAM_running_total/1073741824 > 1) {
	print "The RAM of this host is at least 1 GB in size. Proceed!\n";
} else {
	print "Less than 1 GB of RAM exists on this system. Do not proceed.\n"
}