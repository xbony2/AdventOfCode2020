one = 0
three = 0

loop do
  n = gets

  case n.to_i
  when 1
    one += 1
  when 3
    three += 1
  when -1
    break
  end

  puts "1: #{one}"
  puts "3: #{three}"
end
