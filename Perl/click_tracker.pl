#
#   Waits until N mouse clicks occur before executing (default: 10), Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::API;

my $minClicks = 10;
if (@ARGV == 1) {
	$minClicks = $ARGV[0];
}

my $getAsyncKeyState = new Win32::API("user32", "GetAsyncKeyState", +"I", "N");

my $count = 0;
while ($count < $minClicks) {
	my $leftClick = $getAsyncKeyState->Call(1);	
	my $rightClick = $getAsyncKeyState->Call(2);

	if ($leftClick) {
		++$count;
	}

	if ($rightClick) {
		++$count;
	}

	sleep(1);
}

print "Now that the user has clicked $minClicks times, we may proceed with malware execution!\n"