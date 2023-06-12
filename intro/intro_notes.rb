# This is not a real program. Only for notes.

# Introduction

1.class     # => Fixnum: the number 1 is a Fixnum
0.0.class   # => Float: floating-point numbers have class Float
true.class  # => TrueClass: true is a the singleton instance of TrueClass
false.class # => FalseClass
nil.class   # => NilClass

3.times{print "Ruby!\n"}

1.upto(9) {|x| print x}

a = [3,2,1]
a[3] = a[2] - 1
a.each do |elt|     # each is an iterator. The block has a parameter elt
    print elt + 1
end

a = [1,2,3,4]            # start with an array
b = a.map {|x|x*x}       # square elements: b is [1,4,9,16]
c = a.select {|x|x%2==0} # select even elements: c is [2,4]
a.inject do |sum,x|      # compute the sum of the elements => 10
    sum + x
end



h = {           # A has that maps number names to digits
    :one => 1,  # the "arrows" show mappings: key => value
    :two => 2,  # the colons indicate Symbol literals
}
h[:one]                         # => Access a value by key
h[:three] = 3                   # Add a new/key value pair to the hash
h.each do |key,value|           # iterate through the key/value pairs
    print "#{value}:#{key};"    # note variable substituted into string
end                             # prints "1:one; 2:two; 3:three;"

File.open("data.txt") do |f|    # Open names file and pass stream to block
    line = f.readline           # use the stream to read from the file
end                             # stream automatically closed at block end

t = Thread.new do               # run this block in a new thread
    File.read("data.txt")       # read a file in the background
end

# print "#{value}:#{key};"        # note variables substituted into string

1 + 2
1 * 2
1 + 2 == 3                  # => true: == tests equality
2 ** 1024
"Ruby" "rocks!"              # => "Ruby rocks!" string concatenation
"Ruby!" * 3                  # => "Ruby! Ruby! Ruby!": string repetition
"%d %s" % [3, "rubies"]      # => "3 rubies": python style printf formatting
# max = x>y?x:y              # => the conditional operator

def square(x)   # define a method named square with one parameter x
    x*x         # return x squared
end             # end of the method

# Singletonmethod
def Math.square(x)  # define a class method of the Math module
    x*x
end

=begin

x,y = 1,2       # same as x = 1; y = 2
a,b = b,a       # swap the value of two variables
x,y,x = [1,2,3] # array elements automatically assigned to variables

=end

# define a method to convert Cartesian (x,y) coordinates to Polar
def polar(x,y)
    theta = Math.atan2(y,x)     # compute the angle
    r = Math.hypot(x,y)         # compute the distance
    [r, theta]                  # the last expression is the return value
end

# here's how we use this method with parallel assignment
distance, angle = polar(2,2)

/[Rr]uby/       # Matches "Ruby" or "ruby"
/\d{5}/         # matches 5 consecutive digits
1..3            # all x where 1 <= x <= 3
1...3           # all x where 1 <= x < 3

=begin

# Determine US generation name based on birth year
# Case expression tests ranges with ===
generation = case birthyear
    when 1946..1963:"Baby Boomer"
    when 1964..1976:"Generation X"
    when 1978..2000:"Generation Y"
    else nil
    end

=end

# A method to ask the user to confirm something
def are_you_sure?                   # define a method. Note question mark!
    while true                      # loop until we explicitly return
        print "Are you sure?[y/n]"  # ask the user a question
        response = gets             # get her answer
        case response               # begin case conditional
        when /^[yY]/                # if response begins with y or Y
            return turn             # return true from method
        when /^[nN]/,/^$/           # if response begins with n, N or is empty
            return false
        end
    end
end

# This class represents a sequence of numbers characterized by the three
# parameters from, to, and by. The numbers x in the sequence obey the
# following two constraints:
#
# from <= x <= to
# x = from + n*by, where n is an integer
#
class Sequence
    # This is an enumerable class; it defines an each iterator below.
    include Enumerable  # include the methods of this module in this class

    # the initialize method is special; it is automatically invoked to
    # initialize newly created instances of the class
    def initialize(from, to, by)
        # just save our parameters into instance variables for later use
        @from, @to, @by = from, to, by # Note parallel assignment and @ prefix
    end

    # This is the iterator required by the enumerable module
    def each
        x = @from            # start at the starting point
        while x <= @to       # while we haven't reached the end
            yield x          # pass x to the block associated with the iterator
            x += @by         # increment x
        end
    end

    # define the length method (following arrays) to return the number of
    # values in the sequence
    def length
        return 0 if @from > @to            # note if used as a statement modifier
        Integer((@to-@from)/@by) + 1        # compute and return length of sequence
    end

    # define another name for the same method
    # it is common for the methods to have multiple names in Ruby
    alias size length                       # size is now a synonym for length

    # override the array-access operator to give random access to the
    # sequence
    def[](index)
        return nil if index<0             # return nil for negative indexes
        v = @from + index*@by               # compute the value
        if v<=@to                           # if it is part of the sequence
            v                               # return it
        else                                # otherwise...
            nil                             # return nil
        end
    end

    # override arithmetic  operators to return new sequence objects
    def*(factor)
        Sequence.new(@from*factor, @to*factor,@by*factor)
    end

    def+(offset)
        Sequence.new(@from+offset,@to+offset,@by)
    end
end

s = Sequence.new(1,10,2)    # from 1 to 10 by 2's
s.each{|x| print x}         # prints 1 3 5 7 9
print s[s.size-1]           # prints 9
t = (s+1)*2                 # from 4 to 22 by 4's

module Sequences                         # begin a new module
    def self.fromtoby(from, to, by)      # a singleton method of the module
        x = from
        while x <= to
            yield x
            x += by
        end
    end
end

Sequences.fromtoby(1,10,2){ |x| print x } # prints 1 3 5 7

class Range                         # open n existing class for addition
    def by(step)                    # define an iterator named by
        x = self.begin              # start at one endpoint of the range
        if exclude_end?             # for...ranges that exclude the end
            while x < self.end      # test with the < operator
                yield x
                x += step
            end
        else                        # otherwise, for...ranges that include the end
            while x<= self.end      # test with <= operator
                yield x
                x += step
            end
        end
    end                             # end of method definition
end                                 # end of class modification

(0..10).by(2){ |x| print x }          # 0 2 4 6 8 10
(0...10).by(2){ |x| print x }         # 0 2 4 6 8
