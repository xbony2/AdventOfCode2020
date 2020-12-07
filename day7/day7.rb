$bags = {}

# Represents a bag and a quantity associated with it
class BagTuple
  attr_reader :bag_name, :quantity

  def initialize(bag_name, quantity)
    @bag_name = bag_name
    @quantity = quantity
  end
end

File.open('input.txt', 'r').each do |line|
  m = /(\w+ \w+) bags contain ((?:(?:\d|no) (?:\w+ \w+|other) bag(?:s)?(?:, )?)+.)/.match(line)

  bag_name = m[1]
  contents = []

  contents_string = m[2]

  contents_string.scan(/(\d|no) (\w+ \w+|other) bag(?:s)?/) do |m2|
    contents << BagTuple.new(m2[1], m2[0].to_i) unless m2[0] == "no"
  end

  #puts bag_name
  $bags[bag_name] = contents
end

#puts $bags

# Part 1
# LMAO I didn't optimize this at all but Ruby took care of it!
# A better solution would cache these values.
$search_for = "shiny gold"

def bag_has_bag?(bag_name)
  #puts bag_name

  return false if $bags[bag_name].empty?

  ret = false

  $bags[bag_name].each do |tuple|
    if tuple.bag_name == $search_for
      ret = true
      break
    else
      maybe = bag_has_bag?(tuple.bag_name)

      if maybe
        ret = true
        break
      end
    end
  end

  ret
end

nums = 0

$bags.each_key do |bag_name|
  nums += 1 if bag_has_bag?(bag_name)
end

puts "There are #{nums} bags that contain #{$search_for} bags"

# Part 2
$search_for2 = "shiny gold"

def how_many_bags_in_bag(bag_name)
  puts bag_name

  return 0 if $bags[bag_name].empty?

  num = 0

  $bags[bag_name].each do |tuple|
    num += tuple.quantity * (how_many_bags_in_bag(tuple.bag_name) + 1)
  end

  num
end

puts "There are #{how_many_bags_in_bag($search_for2)} bags in the #{$search_for2} bag"
