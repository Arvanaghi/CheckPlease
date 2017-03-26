use Sys::Hostname;
print "Enter a hostname to validate: ";
my $hostname = <STDIN>;
my $currenthostname = hostname;
if (index(lc($hostname), lc($currenthostname)) != -1){
    print "put real code here"
}