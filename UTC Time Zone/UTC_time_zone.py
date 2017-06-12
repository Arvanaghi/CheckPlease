#
#   Checks if time zone is Coordinated Universal Time (UTC), Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import time

if time.tzname[0] == "Coordinated Universal Time" or time.tzname[1] == "Coordinated Universal Time":
	print("The time zone is Coordinated Universal Time (UTC), do not proceed.")
else:
	print("The time zone zone is " + str(time.tzname[time.daylight]) +". Proceed!")
