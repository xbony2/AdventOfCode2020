require 'set'

nums = Set.new

# Constructs nums set
File.open('input.txt', 'r').each do |num|
  nums << num.to_i
end

# Part One
nums.each do |num|
  alt_num = 2020 - num

  if nums.include?(alt_num)
    puts "The elves want the number #{num * alt_num}"
    break
  end
end

do_break = false

# Part Two
nums.each do |i|
  break if do_break

  combo = 2020 - i # this is the two numbers we want

  nums.each do |j|
    alt_num = combo - j

    if nums.include?(alt_num)
      puts "The elves also want the number #{i * j * alt_num}"
      do_break = true
      break
    end
  end
end
