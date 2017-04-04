#
#   Windows Minimum Number of Running Processes, Python
#   Ensures at least N processes running on the system (defaults to 50)
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import sys
import win32pdh

MinimumNumberOfProcesses = 50

if len(sys.argv) == 2:
	MinimumNumberOfProcesses = sys.argv[1]

_, runningProcesses = win32pdh.EnumObjectItems(None,None,'process', win32pdh.PERF_DETAIL_WIZARD)

if len(runningProcesses) > int(MinimumNumberOfProcesses):
	print("Proceed!")