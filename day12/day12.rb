x = 0
y = 0
direction = 0 # degrees, starting at the east

File.open('input.txt', 'r').each do |line|
  m = /(\w)(\d+)/.match(line)

  action = m[1]
  param = m[2].to_i

  case action
  when 'N'
    y += param
  when 'S'
    y -= param
  when 'E'
    x += param
  when 'W'
    x -= param
  when 'L'
    new_direction = direction + param # TODO: probably a better way to do this
    direction = new_direction > 359 ? new_direction - 360 : new_direction
  when 'R'
    new_direction = direction - param
    direction = new_direction < 0 ? new_direction + 360 : new_direction
  when 'F'
    rads = direction * Math::PI / 180.0
    x += (param * Math.cos(rads)).round
    y += (param * Math.sin(rads)).round
  else
    raise "Unknown action #{action}!!!"
  end

  puts "Did #{action}#{param}, now at #{x}, #{y} (#{direction} degrees)"
end

puts "So, the Manhattan distance is... #{x.abs + y.abs} (from #{x}, #{y})"