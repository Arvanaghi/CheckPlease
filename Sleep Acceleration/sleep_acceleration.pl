#
#   Perl sleep acceleration checker via NTP cluster queries
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use IO::Socket;

sub getNTPTime {

	my $NTPTransmit = pack("B384", "00100011", (0)x14);
	my $sock = IO::Socket::INET->new(Proto => "udp",PeerPort => 123,PeerAddr => "us.pool.ntp.org",Timeout => 4);
	$sock->send($NTPTransmit);
	$sock->recv($NTPTransmit, 384);
	$sock->close;

	my $ntptime;
	my ($Ignore, $ntptime, $Ignore2)=unpack("B319 N B32",$NTPTransmit);
	return $ntptime -= 2208988080;

}

$firstTime = getNTPTime();
print "NTP time (in seconds) before sleeping: $firstTime \n";

print "Attempting to sleep for $ARGV[0] seconds...\n";
sleep($ARGV[0]);

$secondTime = getNTPTime();
print "NTP time (in seconds) after sleeping: $secondTime \n";

my $difference = $secondTime - $firstTime;
print "Difference in NTP times (should be at least $ARGV[0] seconds): $difference \n";

if ($difference >= $ARGV[0]) {
	print "Proceed!\n";
}