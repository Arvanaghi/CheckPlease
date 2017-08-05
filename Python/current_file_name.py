#
#   Ensures the current file name is as expected, Python
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import os
import sys

expectedFileName = ""

if len(sys.argv) != 2:
  print("You must provide a file name to check for.")
  exit(1)
else:
  expectedFileName = sys.argv[1]

if os.path.basename(__file__) == expectedFileName:
  print("The file name is {} as expected. Proceed!".format(expectedFileName))
else:
  print("The file name {0}, not {1} as expected. Do not proceed.".format(os.path.basename(__file__), expectedFileName))