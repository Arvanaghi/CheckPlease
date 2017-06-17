#
#   Minimum number of USB devices ever mounted, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

from winreg import *
import sys

MinimumUSBHistory = 2

if len(sys.argv) == 2:
	MinimumUSBHistory = int(sys.argv[1])

HKLM = ConnectRegistry(None,HKEY_LOCAL_MACHINE)
Opened_HKLM_Key = OpenKey(HKLM, r'SYSTEM\ControlSet001\Enum\USBSTOR')

if QueryInfoKey(Opened_HKLM_Key)[0] >= MinimumUSBHistory:
	print("Proceed!")
else:
	print("Number of USB devices ever mounted: " + str(MinimumUSBHistory))