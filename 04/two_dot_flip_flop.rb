# Two dot flip-flop in Ruby

$state = false              # Global storage for flip-flop state
def flipflop(x)             # Test value of x against flip-flop
  if !$state                # If saved state is false
    result = (x == 3)       # Result is value eof lefthand operand
    if result               # If that result is true
      $state = !(x == 5)    # Then saved state is not of the righthand operand
    end
    result                  # Return result
  else                      # Otherwise, if saved state is true
    $state = !(x == 5)      # Then save the inverse of the righthand operand
    true                    # And return true without testing lefthand
  end
end

(1..10).each { |x| print x if flipflop(x) }

# 345

(1..10).each { |y| print y if y==3..y==5 }

# 345
