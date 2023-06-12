# Add two numbers passed to it on the command line:
# example: ruby add_two_numbers.rb 3.0 7.0
# 10.0

x = ARGV[0].to_f
y = ARGV[1].to_f
sum = x + y
puts sum

