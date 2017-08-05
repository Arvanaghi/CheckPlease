#
#   Ensures there are more than N processes currently running on the system (default: 50), Python
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

if len(runningProcesses) >= int(MinimumNumberOfProcesses):
	print("There are {0} processes running on the system, which satisfies the minimum you set of {1}. Proceed!".format(len(runningProcesses), MinimumNumberOfProcesses))
else:
	print("Only {0} processes are running on the system, which is less than the minimum you set of {1}. Do not proceed.".format(len(runningProcesses), MinimumNumberOfProcesses))