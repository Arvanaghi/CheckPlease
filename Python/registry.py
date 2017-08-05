#
#   Windows Registry key and value checker, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

from winreg import *
import os

EvidenceOfSandbox = []

sandboxStrings = ["vmware","virtualbox","vbox","qemu","xen"]

HKLM_Keys_To_Check_Exist = [r'HARDWARE\DEVICEMAP\Scsi\Scsi Port 2\Scsi Bus 0\Target Id 0\Logical Unit Id 0\Identifier',
r'SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_VMware_&Prod_VMware_Virtual_S',
r'SYSTEM\CurrentControlSet\Control\CriticalDeviceDatabase\root#vmwvmcihostdev',
r'SYSTEM\CurrentControlSet\Control\VirtualDeviceDrivers',
r'SOFTWARE\VMWare, Inc.\VMWare Tools',
r'SOFTWARE\Oracle\VirtualBox Guest Additions',
r'HARDWARE\ACPI\DSDT\VBOX_']

HKLM_Keys_With_Values_To_Parse = [r'SYSTEM\ControlSet001\Services\Disk\Enum\0',
r'HARDWARE\Description\System\SystemBiosInformation',
r'HARDWARE\Description\System\BIOS\SystemManufacturer',
r'HARDWARE\Description\System\BIOS\SystemProductName',
r'HARDWARE\Description\System\VideoBiosVersion',
r'HARDWARE\DEVICEMAP\Scsi\Scsi Port 0\Scsi Bus 0\Target Id 0\Logical Unit Id 0'
]

HKLM = ConnectRegistry(None,HKEY_LOCAL_MACHINE)

for HKLM_Key in HKLM_Keys_To_Check_Exist:
	try:
		Opened_HKLM_Key = OpenKey(HKLM, HKLM_Key)
		EvidenceOfSandbox.append(HKLM_KEY)
	except:
		pass # Do nothing, no evidence of sandbox

for HKLM_Key in HKLM_Keys_With_Values_To_Parse:
	try:
		Opened_HKLM_Key = OpenKey(HKLM, os.path.dirname(HKLM_Key))
		keyVal = QueryValueEx(Opened_HKLM_Key, os.path.basename(HKLM_Key))
		for sandboxString in sandboxStrings:
			if keyVal[0].lower().find(sandboxString):
				EvidenceOfSandbox.append(HKLM_Key + " => " + keyVal[0].lower())
				break
	except:
		pass # Do nothing, no evidence of sandbox

# Check if any evidence of Sandbox present
if not EvidenceOfSandbox:
	print("Proceed!")