require 'data_types'
require 'set'

# TODO: fix this. Sets of triples are not working for whatever reason.

current_y = 0

active_cubes = [] #Set.new

File.open('input.txt', 'r').each do |line|
  line.chars.each_with_index do |c, i|
    active_cubes << Triplet.new(i, current_y, 0) if c == '#'
  end

  current_y += 1
end


def get_neighbors(cube)
  ret = []

  (-1..1).each do |x|
    (-1..1).each do |y|
      (-1..1).each do |z|
        ret << Triplet.new(cube.left + x, cube.middle + y, cube.right + z)
      end
    end
  end

  ret.delete(cube)

  ret
end

#puts get_neighbors(Triplet.new(0, 0, 0))

def pulse(active_cubes)
  new_active_cubes = active_cubes.clone

  for_consideration = Set.new

  active_cubes.each do |c|
    for_consideration << c
    #for_consideration.merge(get_neighbors(c))
    get_neighbors(c).each {|n| for_consideration << n unless for_consideration.include?(n)}
  end

  #puts for_consideration.to_a.to_s

  for_consideration.each do |c|
    if active_cubes.include?(c) # cube is active
      #active_neighbors = 0

      #get_neighbors(c).each do |n|
      #  active_neighbors += 1 if active_cubes.include?(n)
      #end
      active_neighbors = get_neighbors(c).filter {|n| active_cubes.include?(n) } .size
      puts "Inactive cube #{c.to_s} working with #{active_neighbors}"

      new_active_cubes.delete(c) unless active_neighbors == 2 || active_neighbors == 3
    else # cube not active
      active_neighbors = get_neighbors(c).filter {|n| active_cubes.include?(n) } .size
      new_active_cubes << c if active_neighbors == 3
    end
  end

  active_cubes.clear.concat(new_active_cubes)
end

puts active_cubes
pulse(active_cubes)
puts
puts active_cubes.uniq
