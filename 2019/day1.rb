total_fuel = 0

File.open('day1input.txt', 'r').each do |mass|
  total_fuel += (mass.to_i / 3).floor - 2
end

puts "The total fuel amount is #{total_fuel}"

real_fuel = 0

def get_fuel(mass)
  fuel_mass = (mass / 3).floor - 2

  return 0 if fuel_mass <= 0

  fuel_mass + get_fuel(fuel_mass)
end

File.open('day1input.txt', 'r').each do |mass|
  real_fuel += get_fuel(mass.to_i)
end

puts "The real fuel amount is #{real_fuel}"
