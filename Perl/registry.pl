#
#   Windows Registry key and value checker, Perl
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

use Win32::TieRegistry (Delimiter => '\\');
use File::Basename;

my @EvidenceOfSandbox;

my @sandboxStrings= (q{vmware}, q{virtualbox}, q{vbox}, q{qemu}, q{xen});

my @HKLM_Keys_To_Check_Exist = (q{HARDWARE\\DEVICEMAP\\Scsi\\Scsi Port 2\\Scsi Bus 0\\Target Id 0\\Logical Unit Id 0\\Identifier},
  q{SYSTEM\\CurrentControlSet\\Enum\\SCSI\\Disk&Ven_VMware_&Prod_VMware_Virtual_S},
  q{SYSTEM\\CurrentControlSet\\Control\\CriticalDeviceDatabase\\root#vmwvmcihostdev},
  q{SYSTEM\\CurrentControlSet\\Control\\VirtualDeviceDrivers},
  q{SOFTWARE\\VMWare, Inc.\\VMWare Tools},
  q{SOFTWARE\\Oracle\\VirtualBox Guest Additions},
  q{HARDWARE\\ACPI\\DSDT\\VBOX_});

my @HKLM_Keys_With_Values_To_Check = (q{SYSTEM\\ControlSet001\\Services\\Disk\\Enum\\0},
  q{HARDWARE\\Description\\System\\SystemBiosInformation},
  q{HARDWARE\\Description\\System\\VideoBiosVersion},
  q{HARDWARE\\Description\\System\\BIOS\\SystemManufacturer},
  q{HARDWARE\\Description\\System\\BIOS\\SystemProductName},
  q{HARDWARE\\DEVICEMAP\\Scsi\\Scsi Port 0\\Scsi Bus 0\\Target Id 0\\Logical Unit Id 0});


foreach $HKLM_Key (@HKLM_Keys_To_Check_Exist) {
  $openedKey = new Win32::TieRegistry
  'HKEY_LOCAL_MACHINE\\'.$HKLM_Key,{ Access=>Win32::TieRegistry::KEY_READ()|0x100, Delimiter=>'\\' };
  if ($openedKey) {
    push(@EvidenceOfSandbox, "HKLM:\\" . $HKLM_Key);
  }
}

foreach $HKLM_Key (@HKLM_Keys_With_Values_To_Check) {
  ($regVal, $regKey, undef) = fileparse($HKLM_Key);
 
  $openedKey = new Win32::TieRegistry
  'HKEY_LOCAL_MACHINE\\'.$regKey,{ Access=>Win32::TieRegistry::KEY_READ()|0x100, Delimiter=>'\\' };
  if ($openedKey) {
      $regString = $openedKey->GetValue($regVal);
      foreach $sandboxString (@sandboxStrings) {
        if (index(lc($regString), lc($sandboxString)) != -1) {
          push(@EvidenceOfSandbox, "HKLM:\\" . $HKLM_Key . " => " . $regString);
        }
      }
  }
}

if (!@EvidenceOfSandbox) {
  print "Proceed!\n";
} else {
  print join("\n", @EvidenceOfSandbox), "\n";
}