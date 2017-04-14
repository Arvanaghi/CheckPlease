#
#   Minimum number of browsers, Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::TieRegistry (Delimiter => '\\');
use File::Basename;

my $browserCount = 0;

my @browserKeys = (q{SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\App Paths\\chrome.exe},
  q{SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\App Paths\\iexplore.exe},
  q{SOFTWARE\\Mozilla});

foreach $browserKey (@browserKeys) {
  $openedKey = new Win32::TieRegistry
  'HKEY_LOCAL_MACHINE\\'.$browserKey,{ Access=>Win32::TieRegistry::KEY_READ()|0x100, Delimiter=>'\\' };
  if ($openedKey) {
    ++$browserCount;
  }
}

if ($browserCount >= 2) {
  print "Proceed!\n";
} else {
  print "Number of Browsers: " . $browserCount . "\n" 
}