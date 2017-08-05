#
#   Windows Registry key and value checker, Ruby
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

require 'win32/registry'
require 'pathname'

EvidenceOfSandbox = Array.new

sandboxStrings = ['vmware', 'virtualbox', 'vbox', 'qemu', 'xen']

HKLM_Keys_To_Check_Exist = ['HARDWARE\DEVICEMAP\Scsi\Scsi Port 2\Scsi Bus 0\Target Id 0\Logical Unit Id 0\Identifier',
  'SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_VMware_&Prod_VMware_Virtual_S',
  'SYSTEM\CurrentControlSet\Control\CriticalDeviceDatabase\root#vmwvmcihostdev',
  'SYSTEM\CurrentControlSet\Control\VirtualDeviceDrivers',
  'SOFTWARE\VMWare, Inc.\VMWare Tools',
  'SOFTWARE\Oracle\Virtual Box Guest Additionas',
  'HARDWARE\ACPI\DSDT\VBOX_']

HKLM_Keys_With_Values_To_Parse = ['SYSTEM\ControlSet001\Services\Disk\Enum\0',
  'HARDWARE\Description\System\SystemBiosInformation',
  'HARDWARE\Description\System\VideoBiosVersion',
  'HARDWARE\Description\System\BIOS\SystemManufacturer',
  'HARDWARE\Description\System\BIOS\SystemProductName',
  'HARDWARE\DEVICEMAP\Scsi\Scsi Port 0\Scsi Bus 0\Target Id 0\Logical Unit Id 0']

for index in 0 ... HKLM_Keys_To_Check_Exist.size
  begin
    reg_access = Win32::Registry::KEY_READ | 0x100
    Win32::Registry::HKEY_LOCAL_MACHINE.open(HKLM_Keys_To_Check_Exist[index], reg_access) {
      EvidenceOfSandbox.push('HKLM:\\' + HKLM_Keys_To_Check_Exist[index])
    }
  rescue
  end
end

for index in 0 ... HKLM_Keys_With_Values_To_Parse.size
  regKey, regVal = Pathname.new(HKLM_Keys_With_Values_To_Parse[index]).split
  reg_access = Win32::Registry::KEY_READ | 0x100
  begin
    Win32::Registry::HKEY_LOCAL_MACHINE.open(regKey.to_s, reg_access) do |reg|
      regString = reg[regVal.to_s]
      sandboxStrings.each do |sandboxString|
        if regString.downcase.include?(sandboxString.downcase)
          EvidenceOfSandbox.push('HKLM:\\' + HKLM_Keys_With_Values_To_Parse[index] + " => " + regString)
        end
      end
    end
  rescue
  end
end

if EvidenceOfSandbox.empty?
  puts "Proceed!"
else
  puts EvidenceOfSandbox.join("\n")
end