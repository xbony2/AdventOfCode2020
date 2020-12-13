seat_ids = []

File.open('input.txt', 'r').each do |line|
  low = 0
  high = 127
  col_line = ''

  line.each_char do |c|
    diff = (high - low) / 2 + 1
    if c == 'F'
      high -= diff
    elsif c == 'B'
      low += diff
    else
      col_line << c
    end
  end

  col_low = 0
  col_high = 7

  col_line.each_char do |c|
    break if col_low == col_high

    diff = (col_high - col_low) / 2 + 1

    if c == 'L'
      col_high -= diff
    else # always R
      col_low += diff
    end
  end

  id = 8 * low + col_low
  seat_ids << id
end

puts "The max is #{seat_ids.max}"

should_be = (seat_ids.min..seat_ids.max).reduce(:+)
actual = seat_ids.reduce(:+)

puts "My ticket is #{should_be - actual}"
