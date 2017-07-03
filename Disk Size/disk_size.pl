#
#   Minimum disk size checker (default: 50 GB), Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::OLE;

my $minDiskSizeGB = 50;

if (@ARGV > 0) {
  $minDiskSizeGB = $ARGV[0];
}

my $fileSysObj = Win32::OLE->CreateObject("Scripting.FileSystemObject");

my $diskSizeGB = $fileSysObj->GetDrive("C:")->{TotalSize}/1073741824.0;

if ($diskSizeGB > $minDiskSizeGB) {
  print "The disk size of this host is $diskSizeGB GB, which is greater than the minimum you set of $minDiskSizeGB GB. Proceed!\n";
} else {
  print "The disk size of this host is $diskSizeGB GB, which is less than the minimum you set of $minDiskSizeGB GB. Do not proceed.\n";
}