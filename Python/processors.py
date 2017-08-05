import multiprocessing
import sys

if multiprocessing.cpu_count() >= float(sys.argv[1]):
	print("Proceed!")