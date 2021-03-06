# only supports down == 1 or down == 2 because I am lazy
def calc_trees_per_slope(right, down)
  trees = 0
  is_first = true
  down_itr = true
  mov_right = right

  File.open('input.txt', 'r').each do |line|
    if is_first
      is_first = false
      next
    end

    if down == 2 and down_itr
      down_itr = false
      next
    end

    trees += 1 if line[mov_right % 31] == "#"

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
