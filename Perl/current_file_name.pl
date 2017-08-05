#
#   Ensures the current file name is as expected, Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use File::Basename;

my $expectedName = "";

if (@ARGV != 1) {
  print "You must provide a file name to check for.\n";
  exit(1);
} else {
  $expectedName = $ARGV[0];
}

my $actualName = basename($0);

if (index($actualName, $expectedName) != -1) {
  print "The file name is $actualName as expected. Proceed!\n";
} else {
  print "The file name $actualName, not $expectedName as expected. Do not proceed.\n";
}