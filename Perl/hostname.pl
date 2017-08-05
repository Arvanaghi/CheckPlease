use Sys::Hostname;

if (lc(hostname) eq lc(join(" ", @ARGV))) {
    print "Proceed!\n"
}