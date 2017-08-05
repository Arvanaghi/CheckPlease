#
#   Checks if cursor is in same position after sleeping N seconds (default: 20 min), Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

from time import sleep
import win32api
import sys

secs = 1200;
if len(sys.argv) == 2:
	secs = float(sys.argv[1])

x, y = win32api.GetCursorPos()
print("x: " + str(x) + ", y: " + str(y))

sleep(secs)

x2, y2 = win32api.GetCursorPos()
print("x: " + str(x2) + ", y: " + str(y2))

if x - x2 == 0 and y - y2 == 0:
	print("The cursor has not moved in the last {} seconds. Do not proceed.".format(secs))
else:
	print("The cursor is not in the same position as it was {} seconds ago. Proceed!".format(secs))
