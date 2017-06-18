#
#   Checks if cursor is in same position after sleeping N seconds (default: 20 min), Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

from ctypes import Structure, windll, byref, c_ulong
from time import sleep
import sys

secs = 1200;
if len(sys.argv) == 2:
  secs = float(sys.argv[1])

class tagPOINT(Structure):
    _fields_ = [("x", c_ulong), ("y", c_ulong)]

def getCoords():
  coord = tagPOINT()
  windll.user32.GetCursorPos(byref(coord))
  return coord

firstCoord = getCoords()
print("x: " + str(firstCoord.x) + ", y: " + str(firstCoord.y))

sleep(secs)

secondCoord = getCoords()
print("x: " + str(secondCoord.x) + ", y: " + str(secondCoord.y))

if firstCoord.x - secondCoord.x == 0 and firstCoord.y - secondCoord.y == 0:
  print("The cursor has not moved in the last {} seconds. Do not proceed.".format(secs))
else:
  print("The cursor is not in the same position as it was {} seconds ago. Proceed!".format(secs))