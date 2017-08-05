#
#   Minimum Registry size checker (default: 55 MB), Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::OLE;

my $minRegSizeMB = 55;
if (@ARGV > 0) {
  $minRegSizeMB = $ARGV[0];
}

my $wmi = Win32::OLE->GetObject("winmgmts:\\\\localhost\\root\\CIMV2") or die;
my $regCol = $wmi->ExecQuery("SELECT CurrentSize from Win32_Registry") or die;

my $regSize;
foreach my $regObj (in $regCol) { $regSize = $regObj->CurrentSize; }

if ($regSize > $minRegSizeMB) {
  print "The size of the Registry on this host is $regSize MB, which is greater than the minimum you set of $minRegSizeMB MB. Proceed!\n";
} else {
  print "The size of the Registry on this host is $regSize MB, which is less than the minimum you set of $minRegSizeMB MB. Do not proceed.\n"
}