#
#   Ensures the name of the parent process that spawned the payload is as expected, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import os
import sys
import win32com
from win32com.client import GetObject  

expectedParentProc = "firefox"

if len(sys.argv) == 2:
  expectedParentProc = sys.argv[1]

processes = GetObject("winmgmts:").ExecQuery('SELECT CommandLine from Win32_Process WHERE ProcessID = ' + str(os.getppid()))  

for process in processes:
  if expectedParentProc in str(process.Properties_('CommandLine')):
    print("As expected, the parent process for this process is \"{0}\". Proceed!".format(process.Properties_('CommandLine')))
  else:
    print("The parent process for this process is \"{0}\", not \"{1}\" as you expected. Do not proceed.".format(process.Properties_('CommandLine'), expectedParentProc))