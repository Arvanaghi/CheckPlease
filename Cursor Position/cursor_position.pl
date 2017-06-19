#
#   Checks if cursor is in same position after sleeping N seconds (default: 20 min), Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::API;

my $secs = 1200;
if (@ARGV == 1) {
	$secs = $ARGV[0];
}

Win32::API::Struct->typedef( POINT => qw{
    LONG x; 
    LONG y; 
});

Win32::API->Import('user32', 'BOOL GetCursorPos(LPPOINT lpPoint)');

my $point = Win32::API::Struct->new('POINT');
$point->align('auto');
$point->{'x'} = 0; $point->{'y'} = 0;
GetCursorPos($point);
print "x: $point->{x}, y: $point->{y}\n";

sleep($secs);

my $point2 = Win32::API::Struct->new('POINT');
$point2->{'x'} = 0; $point2->{'y'} = 0;
GetCursorPos($point2);
print "x: $point2->{x}, y: $point2->{y}\n";

if ($point->{x} - $point2->{x} == 0 && $point->{y} - $point2->{y} == 0) {
	print "The cursor has not moved in the last $secs seconds. Do not proceed.\n"
} else {
	print "The cursor is not in the same position as it was $secs seconds ago. Proceed!\n"
}