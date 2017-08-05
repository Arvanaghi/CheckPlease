#
#   Minimum number of installed Windows Updates (default: 50), Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::OLE;

my $minUpdates = 50;

if (@ARGV > 0) {
  $minUpdates = $ARGV[0];
}

my $wmi = Win32::OLE->GetObject("winmgmts:\\\\localhost\\root\\CIMV2") or die;
my $numWindowsUpdates = $wmi->ExecQuery("SELECT * from win32_reliabilityRecords WHERE Sourcename = 'Microsoft-Windows-WindowsUpdateClient'")->{Count} or die;

if ($numWindowsUpdates > $minUpdates) {
  print "$numWindowsUpdates Windows Updates have been installed on the system, which is greater than the minimum you set of $minUpdates. Proceed!\n";
} else {
  print "$numWindowsUpdates Windows Updates have been installed on the system, which is less than the minimum you set of $minUpdates. Do not proceed.\n";
}