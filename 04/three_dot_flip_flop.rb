# Three dot flip-flop in Ruby

$state2 = false
def flipflop2(x)
  if !$state2
    $state2 = (x == 3)
  else
    $state2 = !(x >= 3)
    true
  end
end

(1..10).each { |x| print x if flipflop2(x) }

# 34

(1..10).each { |y| print y if y==3...y>=3 }

#34
