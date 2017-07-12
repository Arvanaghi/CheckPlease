#
#   Prompts user with dialog box and waits for response before executing, Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32;

my $dialogBoxTitle = "CheckPlease by \@arvanaghi and \@ChrisTruncer";
my $dialogBoxMessage = "This is a sample dialog box to ensure user activity!";

if (@ARGV == 2) {
	$dialogBoxTitle = $ARGV[0];
	$dialogBoxMessage = $ARGV[1];
}

Win32::MsgBox($dialogBoxMessage, 0, $dialogBoxTitle);