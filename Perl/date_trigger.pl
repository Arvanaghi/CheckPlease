#
#   Waits until a user-defined date to execute, Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Time::Piece;

if (@ARGV != 1) {
	print "You must provide a date in format mm/dd/yyyy.\n";
	exit(1);
}

my $triggerDate = Time::Piece->strptime($ARGV[0], "%m/%d/%Y")->date;

while (Time::Piece->new->date < $triggerDate) {
	sleep(86340);
}

print "Now that today is " . Time::Piece->new->strftime("%m/%d/%Y") . ", we may proceed with malware execution!\n";