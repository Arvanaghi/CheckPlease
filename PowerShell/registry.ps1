#
#   Windows Registry key and value checker, PowerShell
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

$EvidenceOfSandbox = New-Object System.Collections.ArrayList

$sandboxStrings = "vmware","virtualbox","vbox","qemu","xen"

$HKLM_Keys_To_Check_Exist = 'HARDWARE\DEVICEMAP\Scsi\Scsi Port 2\Scsi Bus 0\Target Id 0\Logical Unit Id 0\Identifier',
'SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_VMware_&Prod_VMware_Virtual_S',
'SYSTEM\CurrentControlSet\Control\CriticalDeviceDatabase\root#vmwvmcihostdev',
'SYSTEM\CurrentControlSet\Control\VirtualDeviceDrivers',
'SOFTWARE\VMWare, Inc.\VMWare Tools',
'SOFTWARE\Oracle\VirtualBox Guest Additions',
'HARDWARE\ACPI\DSDT\VBOX_'

$HKLM_Keys_With_Values_To_Parse = 'SYSTEM\ControlSet001\Services\Disk\Enum\0',
'HARDWARE\Description\System\SystemBiosInformation',
'HARDWARE\Description\System\VideoBiosVersion',
'HARDWARE\Description\System\BIOS\SystemManufacturer',
'HARDWARE\Description\System\BIOS\SystemProductName',
'HARDWARE\DEVICEMAP\Scsi\Scsi Port 0\Scsi Bus 0\Target Id 0\Logical Unit Id 0'

ForEach ($HKLM_Key in $HKLM_Keys_To_Check_Exist) {
	if (Test-Path ("HKLM:\" + $HKLM_Key)) {
		[void]$EvidenceOfSandbox.Add("HKLM:\" + $HKLM_Key)
	}
}

ForEach ($HKLM_Key in $HKLM_Keys_With_Values_To_Parse) {
	$Path = "Registry::HKEY_LOCAL_MACHINE\" + (Split-Path $HKLM_Key)
	$Name = (Split-Path $HKLM_Key -Leaf)
	$RegistryValue = (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue).$Name
	ForEach ($sandboxString in $sandboxStrings) {
		try { 
			if ($RegistryValue | Select-String $sandboxString) {
				[void]$EvidenceOfSandbox.Add("HKLM:\" + $HKLM_Key + " => " + $RegistryValue)
			} 
		} catch {}
	}
}

if ($EvidenceOfSandbox.count -eq 0) {
	Write-Output "Proceed!"
}