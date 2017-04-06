username = ENV["USERNAME"].downcase
if username == ARGV.join(" ")
	puts "Proceed!"
end