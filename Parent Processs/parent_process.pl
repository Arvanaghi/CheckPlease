#
#   Ensures the name of the parent process that spawned the payload is as expected, Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::OLE;

my $expectParentProc = "firefox";
if (@ARGV == 1) {
	$expectParentProc = $ARGV[0];
}

my $wmi = Win32::OLE->GetObject("winmgmts:\\\\localhost\\root\\CIMV2") or die;
my $ppidCol = $wmi->ExecQuery("SELECT ParentProcessId from Win32_Process WHERE ProcessId = $$") or die;

my $ppid;
foreach my $ppidObj (in $ppidCol) { $ppid = $ppidObj->ParentProcessId; }

my $parentProcessCol = $wmi->ExecQuery("SELECT Name from Win32_Process WHERE ProcessId = $ppid") or die;
my $parentProcess;
foreach my $parentProcessObj (in $parentProcessCol) { $parentProcess = $parentProcessObj->Name; }

if (index(lc($parentProcess), lc($expectParentProc)) != -1) {
	print "As expected, the parent process for this process is \"$parentProcess\". Proceed!\n";
} else {
	print "The parent process for this process is \"$parentProcess\", not \"$expectParentProc\" as you expected. Do not proceed.\n"
}