#
#   Python sleep acceleration checker via NTP cluster queries
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

from time import sleep
import sys
import datetime
import socket
import struct

def getNTPTime():

	client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	client.sendto((("1b").decode("hex") + 47 * ("01").decode("hex")), ("us.pool.ntp.org",123))
	msg, address = client.recvfrom( 1024 )

	return datetime.datetime.utcfromtimestamp(struct.unpack("!12I",msg)[10] - 2208988800)

firstTime = getNTPTime()
print("NTP time (UTC) before sleeping: " + str(firstTime))

sleep(float(sys.argv[1]))

secondTime = getNTPTime()
print("NTP time (UTC) after sleeping: " + str(secondTime))

difference = secondTime - firstTime
print("Difference in NTP times (should be at least " + sys.argv[1] + " seconds): " + str(difference.seconds))
if difference.seconds >= float(sys.argv[1]):
	print("Proceed!")