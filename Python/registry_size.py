#
#   Minimum Registry size checker (default: 55 MB), Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import sys
import win32com
from win32com.client import GetObject	

minRegistrySizeMB = 55

if len(sys.argv) > 1:
	minRegistrySizeMB	= int(sys.argv[1])

regObjects = GetObject("winmgmts:").ExecQuery("SELECT CurrentSize FROM Win32_Registry")	

for regObject in regObjects:
	if int(regObject.Properties_('CurrentSize')) > minRegistrySizeMB:
		print("The size of the Registry on this host is {0} MB, which is greater than the minimum you set of {1} MB. Proceed!".format(regObject.Properties_('CurrentSize'), minRegistrySizeMB))
	else:
		print("The size of the Registry on this host is {0} MB, which is less than the minimum you set of {1} MB. Do not proceed.".format(regObject.Properties_('CurrentSize'), minRegistrySizeMB))