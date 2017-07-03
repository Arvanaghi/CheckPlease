#
#   Ensures there are more than N processes currently running on the system (default: 50), Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::OLE;

my $minProcesses = 50;
if (@ARGV > 0) {
  $minProcesses = $ARGV[0];
}

my $wmi = Win32::OLE->GetObject("winmgmts:\\\\localhost\\root\\CIMV2") or die;
my $runningProcesses = $wmi->ExecQuery("SELECT * FROM Win32_Process")->{Count} or die;

if ($runningProcesses > $minProcesses) {
  print "There are $runningProcesses processes running on the system, which satisfies the minimum you set of $minProcesses. Proceed!\n"
} else {
  print "Only $runningProcesses processes are running on the system, which is less than the minimum you set of $minProcesses. Do not proceed.\n"
}
