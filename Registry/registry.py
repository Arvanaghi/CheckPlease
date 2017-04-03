#
#   Python Windows Registry Key and Value Checker
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

from winreg import *

EvidenceOfSandbox = []

def searchForSandboxStrings(registryValue):
	print("HEY")
	sandboxStrings = ["vmware","virtualbox","qemu","xen"]
	for sandboxString in sandboxStrings:
		print(sandboxString)
		if registryValue.find(sandboxString):
			print("WOAH!!!")
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
	print(HKLM_Key)
	try:
		Opened_HKLM_Key = OpenKey(HKLM, HKLM_Key)
		print("DEBUG1")
		keyVal = QueryValueEx(key, "Count")
		print(keyVal[0])
		searchForSandboxStrings(keyVal[0].lower())
	except:
		pass # Do nothing, no evidence of sandbox

if not EvidenceOfSandbox:
	print("Proceed!")
else:
	print(EvidenceOfSandbox)


