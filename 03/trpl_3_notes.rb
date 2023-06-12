# This is not a real program. Only for notes.

# Chapter 3 - Datatypes and Objects

# here documents

document = <<HERE
This is a string literal
It has two lines and abruptly ends here...
HERE

greeting = <<HERE + <<THERE + "World"
Hello
HERE
there
THERE

# backtick command execution

# example:

# if windows
#     listcmd = 'dir'
# else
#     listcmd = 'ls'
# end
#     listing = `#{listcmd}`

# easiest:

# listing = Kernel.`(listcmd)

# string literals and mutability

# 10.times { puts "test".object_id}

# string.new method

# character literals

# ?A   Character literal for the ASCII character A
# ?"   Character literal for the double-quote character
# ??   Character literal for the question mark character

=begin

?\u20AC == ?€
?€ == "\u20AC"

?\t      # Character literal for the TAB character
?\C-x    # Character literal for Ctrl-X
?\111    # Literal for character whose encoding is 0111 (octal)

=end

# String Operators

planet = "Earth"
p "Hello" + " " + planet

greeting = "Hello"
greeting <<" "<< "World"
p greeting

alphabet = "A"
alphabet << ?B
alphabet << 67
alphabet << 256
p alphabet

ellipsis = '.'*3
p ellipsis

a = 0
p "#{a = a + 1}"*3

s = 'hello'    # Ruby 1.9
s[0]           # 'h': the first character of the string, as a string
s[s.length-1]  # 'o': the last character 'o'
s[-1]          # 'o': another way of accessing the last character
s[-2]          # 'l': the second-to-last character
s[-s.length]   # 'h': another way of accessing the first character
s[s.length]    # nil: there is no character at that index

=begin

s[0] = ?H        # Replace first character with a capital H
s[-1] = ?O       # Replace last character with a capital O
s[s.length] = ?! # ERROR! Can't assign beyond the end of the string

=end

s = "hello"      # Begin with a greeting
s[-1] = ""       # Delete the last character; s is now "hell"
s[-1] = "p!"     # Change new last character and add one; s is now "help!"

# substrings:

s = "hello"
s[0,2]          # "he"
s[-1,1]         # "o": returns a string, not the character code ?o
s[0,0]          # "": a zero-length substring is always empty
s[0,10]         # "hello": returns all the characters that are available
s[s.length,1]   # "": there is an empty string immediately beyond the end
s[s.length+1,1] # nil: it is an error to read past that
s[0,-1]         # nil: negative lengths don't make any sense

s = "hello"
s[0,1] = "H"              # Replace first letter with a capital letter
s[s.length,0] = " world"  # Append by assigning beyond the end of the string
s[5,0] = ","              # Insert a comma, without deleting anything
s[5,6] = ""               # Delete with no insertion; s == "Hellod"

# range to index string

s = "hello"
s[2..3]                 # "ll": characters 2 and 3
s[-3..-1]               # "llo": negative indexes work, too
s[0..0]                 # "h": this Range includes one character index
s[0...0]                # "": this Range is empty
s[2..1]                 # "": this Range is also empty
s[7..10]                # nil: this Range is outside the string bounds
s[-2..-1] = "p!"        # Replacement: s becomes "help!"
s[0...0] = "Please "    # Insertion: s becomes "Please help!"
s[6..10] = ""           # Deletion: s becomes "Please!"

# index a string with a string

s = "hello"         # Start with the word "hello"
while(s["l"])       # While the string contains the substring "l"
    s["l"] = "L";   # Replace first occurrence of "l" with "L"
end                 # Now we have "heLLo"

s[/[aeiou]/] = '*'  # Replace first vowel with an asterisk

# iterating strings

s = "¥1000"
s.each_char {|x| print "#{x} " }         # Prints "¥ 1 0 0 0". Ruby 1.9
0.upto(s.size-1) {|i| print "#{s[i]} "}  # Inefficient with multibyte chars

# Multibyte characters

# -*- coding: utf-8 -*-   # Specify Unicode UTF-8 characters

# This is a string literal containing a multibyte multiplication character
s = "2x2=4"

# The string contains 6 bytes which encode 5 characters
s.bytesize                                         # => 6
s.bytesize.times {|i| print s.getbyte(i), " "}     # Prints "50 195 151 50 61 52"
s.length                                           # => 5
s.length.times { |i| print s[i], " "}              # Prints "2 × 2 = 4"
# s.setbyte(5, s.getbyte(5)+1);                    # s is now "2×2=5"

# -*- coding: utf-8 -*-

s = "2x2=4"     # Note multibyte multiplication character
p s.encoding    # => <Encoding: UTF-8>

=begin

# force_encoding

text = stream.readline.force_encoding("utf-8")
bytes = text.dup.force_encoding("binary")

=end

s = "\xa4".force_encoding("utf-8")    # This is not a valid UTF-8 string
p s.valid_encoding?                   # => false

s = "sharif".force_encoding("utf-8")
p s.valid_encoding?

# encode method

# -*- coding: utf-8 -*-

euro1 = "\u20AC"                       # Start with the Unicode Euro character
p euro1                                # Prints "€"
p euro1.encoding                       # => <Encoding:UTF-8>
p euro1.bytesize                       # => 3

euro2 = euro1.encode("iso-8859-15")    # Transcode to Latin-15
puts euro2.inspect                     # Prints "\xA4"
p euro2.encoding                       # => <Encoding:iso-8859-15>
p euro2.bytesize                       # => 1

euro3 = euro2.encode("utf-8")          # Transcode back to UTF-8
p euro1 == euro3                       # => true

# Interpret a byte as an iso-8859-15 codepoint, and transcode to UTF-8
byte = "\xA4"
char = byte.encode("utf-8", "iso-8859-15")
p char

=begin

text = bytes.encode(to, from)
text = bytes.dup.force_encoding(from).encode(to)

=end

# the encoding class

Encoding::ASCII_8BIT     # Also ::BINARY
Encoding::UTF_8          # UTF-8-encoded Unicode characters
Encoding::EUC_JP         # EUC-encoded Japanese
Encoding::SHIFT_JIS      # Japanese: also ::SJIS, ::WINDOWS_31J, ::CP932

=begin

Ruby 1.9 also supports the US-ASCII encoding,
the European encodings ISO-8859-1 through ISO-8859-15,
and the Unicode UTF-16 and UTF-32 encodings
in big-endian and little-endian variants.

If you have an encoding name as a string and
want to obtain the corresponding Encoding object,
use the Encoding.find factory method: encoding = Encoding.find("utf-8")

Encoding.list returns an array of all available encoding objects.

Encoding.name_list returns an array of the names (as strings) of
all available encodings. Many encodings have more than one name in common use,
and Encoding.aliases returns a hash that maps encoding aliases
to the official encoding names for which they are synonyms.
The array returned by Encoding.name_list includes
the aliases in the Encoding.aliases hash.

Use Encoding.default_external and Encoding.default_internal to obtain
the Encoding objects that represent the default external and default
internal encodings (see Source, External, and Internal Encodings).
To obtain the encoding for the current locale,
call Encoding.locale_charmap and
pass the resulting string to Encoding.find.

# multibyte characters in 1.8

Jcode?

$KCODE = "u"            # Specify Unicode UTF-8, or start Ruby with -Ku option
require "jcode"         # Load multibyte character support

mb = "2\303\2272=4"     # This is "2×2=4" with a Unicode multiplication sign
mb.length               # => 6: there are 6 bytes in this string
mb.jlength              # => 5: but only 5 characters
mb.mbchar?              # => 1: position of the first multibyte char, or nil
mb.each_byte do |c|     # Iterate through the bytes of the string.
  print c, " "          # c is Fixnum
end                     # Outputs "50 195 151 50 61 52 "
mb.each_char do |c|     # Iterate through the characters of the string
    print c, " "        # c is a String with jlength 1 and variable length
end                     # Outputs "2 × 2 = 4 "

=end

# Arrays

[1, 2, 3]                 # An array that holds three Fixnum objects
[-10...0, 0..10,]         # An array of two ranges; trailing commas are allowed
[[1,2],[3,4],[5]]         # An array of nested arrays
# [x+y, x-y, x*y]         # Array elements can be arbitrary expressions
[]                        # The empty array has size 0

words = %w[this is a test]  # Same as: ['this', 'is', 'a', 'test']
open = %w| ( [ { < |        # Same as: ['(', '[', '{', '<']
white = %W(\s \t \r \n)     # Same as: ["\s", "\t", "\r", "\n"]

p words
p open
p white

empty = Array.new               # []: returns a new empty array
nils = Array.new(3)             # [nil, nil, nil]: new array with 3 nil elements
zeros = Array.new(4, 0)         # [0, 0, 0, 0]: new array with 4 0 elements
copy = Array.new(nils)          # Make a new copy of an existing array
count = Array.new(3) {|i| i+1}  # [1,2,3]: 3 elements computed from index

p nils
p zeros
p copy
p count

a = [0, 1, 4, 9, 16]        # Array holds the squares of the indexes
a[0]                        # First element is 0
a[-1]                       # Last element is 16
a[-2]                       # Second to last element is 9
a[a.size-1]                 # Another way to query the last element
a[-a.size]                  # Another way to query the first element
a[8]                        # Querying beyond the end returns nil
a[-8]                       # Querying before the start returns nil, too

a[0] = "zero"     # a is ["zero", 1, 4, 9, 16]
a[-1] = 1..16     # a is ["zero", 1, 4, 9, 1..16]
a[8] = 64         # a is ["zero", 1, 4, 9, 1..16, nil, nil, nil, 64]
# a[-10] = 100    # Error: can't assign before the start of an array

# Like strings, arrays can also be indexed with two integers
# that represent a starting index and a number of elements,
# or a Range object. In either case, the expression
# returns the specified subarray:

a = ('a'..'e').to_a   # Range converted to ['a', 'b', 'c', 'd', 'e']
a[0,0]                # []: this subarray has zero elements
a[1,1]                # ['b']: a one-element array
a[-2,2]               # ['d','e']: the last two elements of the array
a[0..2]               # ['a', 'b', 'c']: the first three elements
a[-2..-1]             # ['d','e']: the last two elements of the array
a[0...-1]             # ['a', 'b', 'c', 'd']: all but the last element

# When used on the lefthand side of an assignment,
# a subarray can be replaced by the elements of the array on the
# righthand side. This basic operation works
# for insertions and deletions as well:

a[0,2] = ['A', 'B']      # a becomes ['A', 'B', 'c', 'd', 'e']
a[2...5]=['C', 'D', 'E'] # a becomes ['A', 'B', 'C', 'D', 'E']
a[0,0] = [1,2,3]         # Insert elements at the beginning of a
a[0..2] = []             # Delete those elements
a[-1,1] = ['Z']          # Replace last element with another
a[-1,1] = 'Z'            # For single elements, the array is optional
a[-2,2] = nil            # Delete last 2 elements in 1.8; replace with nil in
                         # 1.9

# concatenate two arrays

a = [1, 2, 3] + [4, 5]    # [1, 2, 3, 4, 5]
a = a + [[6, 7, 8]]       # [1, 2, 3, 4, 5, [6, 7, 8]]
# a = a + 9                 # Error: righthand side must be an array

# - operator subtracts

['a', 'b', 'c', 'b', 'a'] - ['b', 'c', 'd']    # ['a', 'a']

# multiplication operator

a = [0] * 8    # [0, 0, 0, 0, 0, 0, 0, 0]

# | and &

a = [1, 1, 2, 2, 3, 3, 4]
b = [5, 5, 4, 4, 3, 3, 2]
a | b                        # [1, 2, 3, 4, 5]: duplicates are removed
b | a                        # [5, 4, 3, 2, 1]: elements are the same,
                             # but order is different
a & b                        # [2, 3, 4]
b & a                        # [4, 3, 2]

# each iterator

a = ('A'..'Z').to_a         # Begin with an array of letters
a.each {|x| print x }       # Print the alphabet, one letter at a time

# other Array methods

=begin

clear, compact!, delete_if, each_index, empty?, fill, flatten!, include?,
index, join, pop, push, reverse, reverse_each, rindex, shift, sort, sort!,
uniq!, and unshift.

=end

# .map = .collect
# .each does It gives you every element so you can work with it,
# but it doesn’t collect the results.
# Each always returns the original, unchanged object.

# hashes

# This hash will map the names of digits to the digits themselves
numbers = Hash.new     # Create a new, empty, hash object
numbers["one"] = 1     # Map the String "one" to the Fixnum 1
numbers["two"] = 2     # Note that we are using array notation here
numbers["three"] = 3

sum = numbers["one"] + numbers["two"]   # Retrieve values like this

numbers = { "one" => 1, "two" => 2, "three" => 3 }

# In general, Symbol objects work more efficiently
# as hash keys than strings do:

numbers = { :one => 1, :two => 2, :three => 3 }

numbers = { one: 1, two: 2, three: 3 }

# hash codes, eql? method

# ranges

1..10      # The integers 1 through 10, including 10
1.0...10.0 # The numbers between 1.0 and 10.0, excluding 10.0 itself

# include?

# cold_war = 1945..1989
# cold_war.include? birthdate.year

r = 'a'..'c'
r.each {|l| print "[#{l}]"}     # Prints "[a][b][c]"
r.step(2) { |l| print "[#{l}]"} # Prints "[a][c]"
r.to_a                          # => ['a','b','c']: Enumerable defines to_a

# 1..3.to_a    # Tries to call to_a on the number 3
(1..3).to_a  # => [1,2,3]

# begin <= x <= end
# begin <= x < end

r = 0...100      # The range of integers 0 through 99
r.member? 50     # => true: 50 is a member of the range
r.include? 100   # => false: 100 is excluded from the range
r.include? 99.9  # => true: 99.9 is less than 100

triples = "AAA".."ZZZ"
triples.include? "ABC"        # true; fast in 1.8 and slow in 1.9
triples.include? "ABCD"       # true in 1.8, false in 1.9
triples.cover?   "ABCD"       # true and fast in 1.9
triples.to_a.include? "ABCD"  # false and slow in 1.8 and 1.9

# symbols

:symbol                   # A Symbol literal
:"symbol"                 # The same literal
:'another long symbol'    # Quotes are useful for symbols with spaces
s = "string"
sym = :"#{s}"             # The Symbol :string
%s["]                     # Same as :'"'

=begin

to see if "some" object has an each method:

o.respond_a? :each

invoking that method:

name = :size
if o.respond_a? name
  o.send(name)
end

=end

# converting string to symbol and vice versa

str = "string"     # Begin with a string
sym = str.intern   # Convert to a symbol
sym = str.to_sym   # Another way to do the same thing
str = sym.to_s     # Convert back to a string
str = sym.id2name  # Another way to do it

# true, false, and nil

# compare to nil

# o == nil
# o.nil?

# object references

s = "Ruby"  # Create a String object. Store a reference to it in s.
t = s       # Copy the reference to t. s and t both refer to the same object.
t[-1] = ""  # Modify the object through the reference in t.
# print s   # Access the modified object through s. Prints "Rub".
t = "Java"  # t now refers to a different object.
print s, t  # Prints "RubJava".

# objects of other classes need to be explicitly created = method name .new

# myObject = myClass.new

# object class and object type

o = "test"  # This is a value
o.class     # Returns an object representing the String class

# class hierarchy of an object

o.class                         # String: o is a String object
o.class.superclass              # Object: superclass of String is Object
o.class.superclass.superclass   # nil: Object has no superclass

# Ruby 1.9 only

Object.superclass             # BasicObject: Object has a superclass in 1.9
BasicObject.superclass        # nil: BasicObject has no superclass

# direct comparison

o.class == String       # true if o is a String
o.instance_of? String   # true if o is a String (more elegant)

# to know if the object is an instance of any subclass of that class.

x = 1                    # This is the value we're working with
x.instance_of? Fixnum    # true: is an instance of Fixnum
x.instance_of? Numeric   # false: instance_of? doesn't check inheritance
x.is_a? Fixnum           # true: x is a Fixnum
x.is_a? Integer          # true: x is an Integer
x.is_a? Numeric          # true: x is a Numeric
x.is_a? Comparable       # true: works with mixin modules, too
x.is_a? Object           # true for any value of x


# The Class class defines the === operator in such a way
# that it can be used in place of is_a?:

Numeric === x            # true: x is_a Numeric

# respond_to? method

o.respond_to? :"<<"      # true if o has an << operator

# to explicitly rule out Numeric objects with the is_a? method:

o.respond_to? :"<<" and not o.is_a? Numeric

# object equality

# equal? method = to test if two values refer to exactly the same object

a = "Ruby"       # One reference to one String object
b = c = "Ruby"   # Two references to another String object
a.equal?(b)      # false: a and b are different objects
b.equal?(c)      # true: b and c refer to the same object

a.object_id == b.object_id   # Works like a.equal?(b)

# == operator

a = "Ruby"    # One String object
b = "Ruby"    # A different String object with the same content
a.equal?(b)   # false: a and b do not refer to the same object
a == b        # true: but these two distinct objects have equal values

# In Ruby, classes define an ordering by implementing the <=> operator.
# This operator should return –1 if its left operand is less than its right
# operand,
# 0 if the two operands are equal, and 1 if the left operand is greater than
# the right operand.
# If the two operands cannot be meaningfully compared
# (if the right operand is of a different class, for example),
# then the operator should return nil:

1 <=> 5     # -1
5 <=> 5     # 0
9 <=> 5     # 1
"1" <=> 5   # nil: integers and strings are not comparable

1.between?(0,10) # true: 0<=1<=10

# NaN

nan = 0.0/0.0;        # cannot divide by zero
nan < 0               # false
nan > 0               # false
nan == 0              # false
nan == nan            # false
nan.equal?(nan)       # true

# Object Conversion

# to_s, to_i, to_f, and to_a to convert to String, Integer, Float, and Array,
# respectively.
# Ruby 1.9 adds to_c and to_r methods to convert to Complex and Rational.

# arithmetic operator type coercions

1.1.coerce(1)       #[1.0, 1.1]: coerce Fixnum to Float
require "rational"  # use rational numbers
r = Rational(1, 3)  # one third as a rational number
r.coerce(2)         #[Rational(2,1), Rational(1,3)]: Fixnum to Rational

# marshaling I/O stream

Marshal.dump
Marshal.load

# create deep copies

def deepcopy(o)
  Marshal.load(Marshal.dump(o))
end

# YAML Ain't Markup Language - alternative to Marshal module
# that dumps objects to human readable text format.

# freeze objects

s = "ice"     # strings are mutable objects
s.freeze      # makes immutable
s.frozen?      # true
s.upcase!     # TypeError: can't modify frozen string
s[0] = "ni"   # "         "

# freezing a class object prevents the addition of any methods to that class
# dup only way to unfreeze object

# tainted and untrusted objects (avoid SQL injections)

s = "untrusted"     # objects are normally tainted
s.tainted           # mark this untrusted object as tainted
s.tainted?          # true
s.upcase.tainted?   # true
s[3,4].tainted?     # true

# global variable $SAFE

# to check and set the trustedness of an object:

untrusted?
untrust
trust
