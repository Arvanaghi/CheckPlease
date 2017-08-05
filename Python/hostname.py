import sys
import os

if os.environ['COMPUTERNAME'].lower() == " ".join(sys.argv[1:]).lower():
	print("Proceed!")