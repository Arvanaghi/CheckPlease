currentname = ENV["USERNAME"].downcase
puts "What username should your program run as?"
requested_name = gets.chomp.downcase
if currentname[requested_name]
    puts "Put real code here"
end