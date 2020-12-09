preamble = []

preamble_length = 25

invalid_num = -1

# Part 1
File.open('input.txt', 'r').each do |line|
  num = line.to_i

  if preamble.size < preamble_length
    preamble << num
    next
  end

  found = false

  preamble.each do |p|
    alt_num = (num - p).abs

    found = true if preamble.include?(alt_num)
  end

  unless found
    puts "#{num} was not found!"
    invalid_num = num
    break
  end

  preamble.delete_at(0)
  preamble << num
end

# Part 2
candidates = []

File.open('input.txt', 'r').each do |line|
  num = line.to_i

  candidates << num
end

combo = []

candidates.each_with_index do |c, i|
  next if c >= invalid_num

  additives = [c]

  loop do
    additives << candidates[i + additives.size]
    sum = additives.sum

    if sum == invalid_num
      puts "#{additives} is the combo"
      combo = additives
      break
    elsif sum > invalid_num
      break
    end
  end
end

puts "The weakness is #{combo.min + combo.max}"
