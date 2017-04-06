use Win32::API;

my $username = Win32::LoginName;

if (lc($username) eq join(" ", @ARGV)) {
    print "Proceed!\n"
}