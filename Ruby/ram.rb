#
#   Minimum RAM size checker, Ruby
#   Module written by Brandon Arvanaghi 
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

total_RAM = []
IO.popen('WMIC OS get TotalVisibleMemorySize /Value') { |io| io.each { |line| total_RAM.push(line) } }
if (total_RAM[4].split('=')[1].to_f/1048576 > 1)
	puts "The RAM of this host is at least 1 GB in size. Proceed!"
else
	puts "Less than 1 GB of RAM exists on this system. Do not proceed."
end