# game: guess number
# author: Ryan Duan

n = rand(10)

while not (input = gets().strip()) == "q"
  g = input.to_i
  if g > n
    puts "too high"
    # puts n
  elsif g < n
    puts "too low"
    # puts n
  else
    puts "congrats!"
    puts(sprintf("the number is %d", n))
    exit 0
  end
end
