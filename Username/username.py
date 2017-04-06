import sys
import getpass

if getpass.getuser().lower() == " ".join(sys.argv[1:]).lower():
    print("Proceed!")