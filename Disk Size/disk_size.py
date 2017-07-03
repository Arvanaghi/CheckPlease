#
#   Minimum disk size checker (default: 50 GB), Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import win32api
import sys

minDiskSizeGB = 50

if len(sys.argv) > 1:
    minDiskSizeGB = float(sys.argv[1])

_, diskSizeBytes, _ = win32api.GetDiskFreeSpaceEx()

diskSizeGB = diskSizeBytes/1073741824

if diskSizeGB > minDiskSizeGB:
    print("The disk size of this host is {0}, which is greater than the minimum you set of {1} GB. Proceed!".format(diskSizeGB, minDiskSizeGB))
else:
    print("The disk size of this host is {0}, which is less than the minimum you set of {1} GB. Do not proceed.".format(diskSizeGB, minDiskSizeGB))