# Read and print text file

File.open("data.txt", "r") do |f|
  f.each_line do |line|
    puts line
  end
end

# IO.read method

file_contents = IO.read("data.txt")
puts file_contents
