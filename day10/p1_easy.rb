nums = []

File.open('input.txt', 'r').each do |line|
  nums << line.to_i
end

nums << 0

nums.sort!

# Part 1
ones = 0
threes = 0

nums.each_with_index do |n, i|
  n2 = nums[i + 1]

  break if n2.nil?

  diff = n2 - n

  if diff == 1
    ones += 1
  elsif diff == 3
    threes += 1
  else
    raise "The difference is #{diff} which is unusual."
  end
end

threes += 1 # the device

puts "There are #{ones} ones, #{threes} threes, so you're looking for #{ones * threes}."
