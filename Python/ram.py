#
#   Minimum RAM size checker, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import ctypes

class MEMORYSTATUSEX(ctypes.Structure):
	_fields_ = [
		("dwLength", ctypes.c_ulong),
		("dwMemoryLoad", ctypes.c_ulong),
		("ullTotalPhys", ctypes.c_ulonglong),
		("ullAvailPhys", ctypes.c_ulonglong),
		("ullTotalPageFile", ctypes.c_ulonglong),
		("ullAvailPageFile", ctypes.c_ulonglong),
		("ullTotalVirtual", ctypes.c_ulonglong),
		("ullAvailVirtual", ctypes.c_ulonglong),
		("sullAvailExtendedVirtual", ctypes.c_ulonglong),
	]

memoryStatus = MEMORYSTATUSEX()
memoryStatus.dwLength = ctypes.sizeof(MEMORYSTATUSEX)
ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(memoryStatus))

if memoryStatus.ullTotalPhys/1073741824 > 1:
	print("The RAM of this host is at least 1 GB in size. Proceed!\n")
else:
	print("Less than 1 GB of RAM exists on this system. Do not proceed.\n")