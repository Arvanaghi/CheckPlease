#
#   Minimum number of installed Windows Updates (default: 50), Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import sys
import win32com
from win32com.client import GetObject  

minUpdates = 50

if len(sys.argv) > 1:
  minUpdates = int(sys.argv[1])

numWindowsUpdates = len(GetObject("winmgmts:").ExecQuery("SELECT * from win32_reliabilityRecords WHERE Sourcename = 'Microsoft-Windows-WindowsUpdateClient'"))

if numWindowsUpdates > minUpdates:
  print("{0} Windows Updates have been installed on the system, which is greater than the minimum you set of {1}. Proceed!".format(numWindowsUpdates, minUpdates))
else:
  print("{0} Windows Updates have been installed on the system, which is greater than the minimum you set of {1}. Proceed!".format(numWindowsUpdates, minUpdates))