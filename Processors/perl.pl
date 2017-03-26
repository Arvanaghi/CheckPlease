print "Enter a the minumum amount of processors: ";
chomp ($procs = <>);
my $actualprocs = $ENV{"NUMBER_OF_PROCESSORS"};
if ($actualprocs >= $procs){
    print "put real code here"
}