# This is not a real program. Only for notes.

# Chapter 5 - Statements and Control Structures

# conditions

# If x is less than 10, increment  (all three below work):

x = 3

if x < 10
  x += 1
end

if x < 10 then x += 1 end

if x < 10 then
  x += 1
end

p x     # 6

data = [1,2,3,4,5]

if data           # if the array exists
  data << x       # then append a value
else              # otherwise....
  data = [x]      # create new array that holds the value
end

p data #[1,2,3,4,5,6]

if x == 1
  name = "one"
elsif x == 2
  name = "two"
elsif x == 3 then name = "three"
elsif x == 4; name = "four"
else
  name = "many"
end

# multi-way conditional

name = if x == 1 then "one"
  elsif x == 2 then "two"
  elsif x == 3 then "three"
  elsif x == 4 then "four"
  else       "many"
  end

# if as modifier
# code if expression
# use when condition is almost always true, or trivial

y = x.invert if x.respond_to? :invert
p y # nil
y = (x.invert if x.respond_to? :invert)
p y # nil

# unless - executes code that evaluates to false or nil

=begin

# single-way unless statement
unless condition
  code
end

# two-way unless statement
unless condition
  code
else
  code
end

# unless modifier
code unless condition

=end

# call the to_s method on object o, unless o is nil
s = unless o.nil?                   # newline seperator
  o.to_s
end

s = unless o.nil? then o.to_s end   # then separator

unless x == 0
  puts "x is not 0"
else
  unless y == 0
    puts "y is not 0"
  else
    unless z == 0
      puts "z is not 0"
    else
      puts "all are 0"
    end
  end
end

# case
# both are equivalent

name = case
  when x == 1 then "one"
  when x == 2 then "two"
  when x == 3 then "three"
  when x == 4 then "four"
  else "many"
  end

name = if x == 1 then "one"
  elsif x == 2 then "two"
  elsif x == 3 then "three"
  elsif x == 4 then "four"
  else "many"
  end

# then replaced with newline

case
when x == 1
  "one"
when x == 2
  "two"
when x == 3
  "three"
end

case
when x == 1, y == 0 then "x is one or y is zero"    # obscure syntax
when x == 2 || y == 1 then "x is two or y is one"   # easier to understand
end

name = case x
  when 1                # just the value to compare to x
    "one"               # then keyword instead of newline
  when 2 then "two"     # semicolon instead of newline
  when 3; "three"       # optional else clause at end
  else "many"
  end

# === case equality operator

name = case
  when 1 === x then "one"
  when 2 === x then "two"
  when 3 === x then "three"
  else "many"
  end

# take different actions depending on the class of x
puts case x
  when String then "string"
  when Numeric then "number"
  when TrueClass, FalseClass then "boolean"
  else "other"
  end

# 2006 US Income tax program
# Program for user input, process it, ignoring comments

# multiple expressions

def hasValue?(x)
  case x
  when nil, [], "", 0         # if nil === x||[] === x||"" === x||0 === x then
    false
  else
    true
  end
end

# ?: operator

def how_many_messages(n)     # handle singular/plural
  "You have" + n.to_s + (n==1 ? "message." : "messages.")   # ? then : else
end

# Loops
# while and until

# count down from 10
x = 10
while x >= 0 do
  puts x
  x = x - 1
end

# count back up to 10 using until loop
x = 0
until x > 10 do
  puts x
  x = x + 1
end

# while ans until as modifiers

x = 0
puts x = x + 1 while x < 10     # output and increment in a single expression

x = 0
while x < 10 do puts x = x + 1 end

a = [1, 2, 3]
puts a.pop until a.empty?       # pop elements from array until empty

x = 10
begin         # start a compound expression: executed at least once
  puts x
  x = x - 1
end until x == 0

# for/in loop

# print elements in an array
array = [1, 2, 3, 4, 5]
for element in array
  puts element
end

# print the keys and values in a hash
hash = {:a=>1, :b=>2, :c=>3}
for key, value in hash
  puts "#{key} => #{value}"
end

# each iterator
hash = {:a=>1, :b=>2, :c=>3}
hash.each do |key, value|
  puts "#{key} => #{value}"
end

# Iterators and Enumerable Objects

3.times { puts "thank you!" }     # thank you 3 times
data.each { |x| puts x }          # print each element x of data
[1, 2, 3].map { |x| x * x }       # compute squares of array elements
factorial = 1
2.upto(n) { |x| factorial *= x }  # compute factorial of n

# We use the term iterator in this book to mean any method
# that uses the yield statement.

# numeric iterators

4.upto(6) { |x| print x }                       # 456
3.times { |x| print x }                         # 012
0.step(Math::PI, 0.1) { |x| puts Math.sin(x) }

# enumerable objects

[1, 2, 3].each { |x| print x }                  # 123
(1..3).each { |x| print x }                     # 123, same as 1.upto(3)

# Input/Output Object

File.open(filename) do |f|
  f.each { |line| print line }
end

# each_with_index allows us to add line numbering

File.open(filename) do |f|
  f.each_with_index do |line, number|
    print "#{number}: #{line}"
  end
end

# most common enumerable methods:
# collect (map), select, reject, and inject

squares = [1, 2, 3].collect { |x| x*x }     # => [1,4,9]
evens = (1..10).select { |x| x%2 == 0 }     # => [2,4,6,8,10]
odds = (1..10).reject { |x| x%2 == 0 }      # => [1,3,5,7,9]

