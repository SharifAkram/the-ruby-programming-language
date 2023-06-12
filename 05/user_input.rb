# Get user's input and process it, ignoring comments and exiting
# when the user enters the word "quit"

while line = gets.chomp do  # Loop, asking the user for input each time
  case line
  when /^\s*#/              # if input looks like a comment
    next
  when /^quit$/i            # if input is quit (case insensitive)
    break
  else
    puts line.reverse       # reverse the user's input and print it.
  end
end
