#
#   Minimum number of USB devices ever mounted, Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::TieRegistry( Delimiter=>"\\");

my $MinimumUSBHistory = 2;
if (@ARGV >= 1) {
	$MinimumUSBHistory = $ARGV[0];
}

$BaseKey = $Registry->Open("HKEY_LOCAL_MACHINE\\SYSTEM\\ControlSet001\\Enum\\USBSTOR", { Access=>Win32::TieRegistry::KEY_READ()|0x100 });

if (scalar(keys %$BaseKey) >= $MinimumUSBHistory) {
	print "Proceed!\n";
} else {
	print "Number of USB devices ever mounted: " .scalar(keys %$BaseKey) . "\n";
}