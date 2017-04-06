import sys
import getpass

user_name = getpass.getuser().lower()

if user_name == " ".join(sys.argv[1:]):
    print("Proceed!")