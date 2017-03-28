use Net::Domain qw (hostdomain);
print "Enter a domain to validate: ";
my $domain = <STDIN>;
my $currentdomain = hostdomain();
if (index(lc($hostname), lc($currenthostname)) != -1){
    print "put real code here"
}