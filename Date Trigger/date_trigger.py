#
#   Waits until a user-defined date to execute, Python
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

from datetime import datetime
import time
import sys

if len(sys.argv) != 2:
	print("You must provide a date in format mm/dd/yyyy.")
	sys.exit(1)

triggerDate = datetime.fromtimestamp(time.mktime(time.strptime(sys.argv[1], "%m/%d/%Y")))

while datetime.now().replace(hour=0, minute=0, second=0, microsecond=0) < triggerDate:
	time.sleep(86340)

print("Now that today is {}, we may proceed with malware execution!".format(datetime.now().strftime("%m/%d/%Y")))