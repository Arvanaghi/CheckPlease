#
#   Checks if process is currently being debugged, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

from ctypes import *

isDebuggerPresent = windll.kernel32.IsDebuggerPresent()

if (isDebuggerPresent):
	print("A debugger is present, do not proceed.")
else:
	print("No debugger is present. Proceed!")