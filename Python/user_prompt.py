#
#   Prompts user with dialog box and waits for response before executing, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import ctypes
import sys

dialogBoxTitle = "CheckPlease by @arvanaghi and @ChrisTruncer";
dialogBoxMessage = "This is a sample dialog box to ensure user activity!"

if len(sys.argv) == 3:
	dialogBoxTitle = sys.argv[1]
	dialogBoxMessage = sys.argv[2]

MessageBox = ctypes.windll.user32.MessageBoxW
MessageBox(None, dialogBoxMessage, dialogBoxTitle, 0)

print("Now that the user has clicked \"OK\" or closed the dialog box, we will proceed with malware execution!")