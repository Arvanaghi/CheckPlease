use Net::Domain qw (hostdomain);

if (lc(hostdomain()) eq lc(join(" ", @ARGV))) {
    print "Proceed!"
}