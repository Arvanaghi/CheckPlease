#
#   Windows Registry Key and Value Checker, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

from winreg import *

EvidenceOfSandbox = []

def searchForSandboxStrings(registryValue):
	sandboxStrings = ["vmware","virtualbox","qemu","xen"]
	for sandboxString in sandboxStrings:
		if registryValue.find(sandboxString):
			EvidenceOfSandbox.append(registryValue)
			return

HKLM_Keys_To_Check_Exist = [r'HARDWARE\DEVICEMAP\Scsi\Scsi Port 2\Scsi Bus 0\Target Id 0\Logical Unit Id 0\Identifier',
r'SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_VMware_&Prod_VMware_Virtual_S',
r'SYSTEM\CurrentControlSet\Control\CriticalDeviceDatabase\root#vmwvmcihostdev',
r'SYSTEM\CurrentControlSet\Control\VirtualDeviceDrivers']

HKLM_Keys_With_Values_To_Parse = [r'SYSTEM\ControlSet001\Services\Disk\Enum']

HKLM = ConnectRegistry(None,HKEY_LOCAL_MACHINE)

for HKLM_Key in HKLM_Keys_To_Check_Exist:
	try:
		Opened_HKLM_Key = OpenKey(HKLM, HKLM_Key)
		EvidenceOfSandbox.append(HKLM_KEY)
	except:
		pass # Do nothing, no evidence of sandbox

for HKLM_Key in HKLM_Keys_With_Values_To_Parse:
	try:
		Opened_HKLM_Key = OpenKey(HKLM, HKLM_Key)
		keyVal = QueryValueEx(Opened_HKLM_Key, "0")
		searchForSandboxStrings(keyVal[0].lower())
	except:
		pass # Do nothing, no evidence of sandbox

# Check if any evidence of Sandbox present
if not EvidenceOfSandbox:
	print("Proceed!")


