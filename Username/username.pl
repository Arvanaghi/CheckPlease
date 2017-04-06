use Win32::API;

if (lc(Win32::LoginName) eq lc(join(" ", @ARGV))) {
    print "Proceed!\n"
}