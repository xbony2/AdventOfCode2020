class String
  def numeric?
    Float(self) != nil rescue false
  end
end

time = 0
ids = []

File.open('input.txt', 'r').each do |line|
  if time == 0
    time = line.to_i
  else
    ids = line.split(',').select(&:numeric?).map(&:to_i)
  end
end

# Part 1
earliest_bus_leaves = ids.map { |n| (Float(time) / n).floor * n + n}
earliest_index = earliest_bus_leaves.find_index(earliest_bus_leaves.min)

#puts ids
#puts ids.class
#puts earliest_index
#puts earliest_index.class

earliest_bus = ids[earliest_index]
time_waited = earliest_bus_leaves[earliest_index] - time

puts "The bus is #{earliest_bus}, and we need to wait #{time_waited} seconds (?) for it."
puts "So we want #{earliest_bus * time_waited}"

# Part 2
# TODO: Chinse number theorem (lol)
co_ef = []
t_inc = []
# co_ef[in] * x - t = t_inc[in]

File.open('input.txt', 'r').each do |line|
  next unless line.include?(',')

  line.split(',').each_with_index do |n, i|
    if n.numeric?
      co_ef << n.to_i
      t_inc << i
    end
  end
end

co_ef.each_with_index do |c, i|
  print "#{c}*x#{i} - t == #{t_inc[i]}"
  print " && " if i != co_ef.size - 1
end
puts

puts
co_ef.each_with_index do |c, i|
  puts "#{c}*x#{i} - #{t_inc[i]} == t"
end

puts
co_ef.each_with_index do |c, i|
  puts "x#{i} == (t + #{t_inc[i]})/#{c}"
end

puts
co_ef.each_with_index do |c, i|
  puts "#{c}*x#{i} - t == #{t_inc[i]}"
end

puts
co_ef.each_with_index do |c, i|
  puts "x ≡ #{t_inc[i]} (mod #{c})"
end

x = 0

co_ef.each_with_index do |c, i|
  x += t_inc[i] * (co_ef / c) * (co_ef % t_inc[i])
end
