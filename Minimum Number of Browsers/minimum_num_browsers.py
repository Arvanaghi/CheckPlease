#
#   Minimum number of browsers, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

from winreg import *
import os

browserCount = 0

browserKeys = [r'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe', r'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\iexplore.exe', r'SOFTWARE\Mozilla']

HKLM = ConnectRegistry(None,HKEY_LOCAL_MACHINE)

for browserKey in browserKeys:
	try:
		Opened_Key = OpenKey(HKLM, browserKey)
		browserCount += 1
	except:
		pass 

if browserCount >= 2:
	print("Proceed!")
else:
	print("Number of Browsers: " + str(browserCount))