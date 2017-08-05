import socket
import sys

if socket.getfqdn().lower() == " ".join(sys.argv[1:]).lower():
	print("Proceed!") 
