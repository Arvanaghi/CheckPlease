use Win32::API;
print "Enter a username to validate: ";
my $username = <STDIN>;
my $currentuser = Win32::LoginName;
if (index(lc($currentuser), lc($username)) != -1){
    print "put real code here"
}