#
#   Checks if time zone is Coordinated Universal Time (UTC), Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use POSIX;

if (strftime("%Z", localtime()) eq "Coordinated Universal Time") {
	print "The time zone is Coordinated Universal Time (UTC), do not proceed.\n";
} else {
	print "The time zone is " . strftime("%Z", localtime()) . ". Proceed!\n";
}