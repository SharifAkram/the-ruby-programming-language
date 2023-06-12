# This is not a real program. Only for notes.

# Chapter 4 - Expressions and Operators

# keyword literals:

nil
true
false
self
_FILE_
_LINE_
_ENCODING_

# define a constant

CM_PER_INCH = 2.54
CM_PER_INCH

# constant defined in the conversions module

Conversions:CM_PER_INCH

# constant defined by an element of an array

modules[0]::name

# nested modules

Conversions::Area::HECTARES_PER_ACRE

# array access

a.[](0)

# parallel assignment

x,y,z = 1,2,3

# assigning values to arrays

o[x] = y
o.[] = (x, y)     # same as above example

o[x, y] = z
o.[] = (x, y, z)  # same as above example

# abbreviated assignment, when lvalue is attribute

o.m += 1
o.m = (o.m()+1)   # same as above example

o[x] -= 2         # o.[] = (x, o.[](x)-2)

# parallel assignment
# one lvalue and multiple rvalues

x = 1, 2, 3   # x = [1, 2, 3]

x, = 1, 2, 3  # x = 1; other values discarded

# multiple lvalues, single array rvalue

x, y, z = [1, 2, 3]   # same as x, y, z = 1, 2, 3

x, = [1, 2]           # becomes 1; the trailing comma makes it parallel

# different numbers of lvalues and rvalues

x, y, z = 1, 2        # x = 1; y = 2; z = nil
x, y = 1, 2, 3        # x = 1; y = 2; 3

# splat operator rvalue = value is an array (or array like object)

x, y, z = 1, *[2, 3]  # same as x, y, z = 1, 2, 3

# lvalue with splat
x, *y = 1, 2, 3   # x = 1; y = [2, 3]
x, *y = 1, 2      # x = 1; y = [2]
x, *y = 1         # x = 1; y = []

*x, y = 1, 2, 3   # x = [1, 2]; y = 3
*x, y = 1, 2      # x = [1]; y = 2
*x, y = 1         # x = [];, y = 1

x, y, *z = 1, *[2, 3, 4]    # x = 1; y = 2; z = [3, 4]

# parentheses in parallel assignment

x, y, z = 1, [2, 3]                   # x = 1; y = [2, 3]; z = nil
x, (y, z) = 1, [2, 3]                 # x = 1; y = 2; z = 3
a, b, c, d = [1, [2, [3, 4]]]         # a = 1; b = [2, [3, 4]]; c = d = nil
a, (b, (c, d)) = [1, [2, [3, 4]]]     # a = 1; b = 2; c = 3; d = 4

# shift and append: << and >>

(0b1011 << 1).to_s(2)   # "10110"
(0b10110 >> 2).to_s(2)  # "101"

# try in irb

message = "hello"
messages = []
message << "world"
messages << message
STDOUT << message

# comparisons

# declare class A as a subclass of B

class A < b
end

String < Object    # true
Object > Numeric   # true
Numeric < Integer  # false
String < Numeric   # nil

# Boolean operators - &&, ||, !, and, or, not

x == 0 && y > 1
x && y
x && print(x.to_s)
x < 0 || y < 0 || z < 0

# if argument x is nil, then get its value from a hash of user preferences
# or from a constant default value
x = x || preferences[:x] || Defaults::X

1 || 2 && nil # 1
(1 || 2) && nil # nil

!(a && b)
!a || !B

# two and three dot flip flops
# read text program

# conditional ?:

x == 3?y:z  # legal
3 == x?y:z  # not legal
(3 == x)?y:z  # () fixes the problem
3 == x ?y:z   # space resolves problem

a ? b : c ? d: e  # is evaluated like this a ? b: (c ? d: e)

max = x>y ? x>z ? x : z : y>z ? y : z
max2 = x>y ? (x?z ? x : z) : (y>z ? y : z)

x = y = z = 0       # assign zero to all variables
x = (y = (z = 0))   # this shows order of evaluation

# defined? operator

# Compute f(x), but only if f and x are both defined
y = f(x) if defined? f(x)

defined? a and defined? b     # this works
defined? a && defined? b      # evaluated as: defined?((a && defined? b))
