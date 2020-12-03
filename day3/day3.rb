trees = 0
is_first = true
right = 3

File.open('input.txt', 'r').each do |line|
  if is_first
    is_first = false
    next
  end

  trees += 1 if line[right % 31] == "#"

  right += 3
end

puts "There are #{trees} trees."

# Part 2
def calc_trees_per_slope(right, down)
  trees = 0
  is_first = true
  down_itr = true
  mov_right = right

  File.open('input.txt', 'r').each do |line|
    #puts "start: #{line}" if down == 2 # debug
    if is_first
      is_first = false
      next
    end

    if down == 2 and down_itr
      down_itr = false
      next
    end

    trees += 1 if line[mov_right % 31] == "#"

    line[mov_right % 31] = "X" if down == 2 # debug
    #puts "change: #{line}" if down == 2

    down_itr = true

    mov_right += right
  end

  puts "There are #{trees} trees while going #{right} right and #{down} down."

  trees
end

s1 = calc_trees_per_slope(1, 1)
s2 = calc_trees_per_slope(3, 1)
s3 = calc_trees_per_slope(5, 1)
s4 = calc_trees_per_slope(7, 1)
s5 = calc_trees_per_slope(1, 2)

puts "Together, this is #{s1 * s2 * s3 * s4 * s5}"
