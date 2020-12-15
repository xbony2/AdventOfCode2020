nums = []

File.open('input.txt', 'r').each do |line|
  nums = line.split(',').map {|n| n.to_i}
  #puts nums
end

(2020 - nums.length).times do
  last = nums.last

  if nums.count(last) == 1 # first time called
    nums << 0
  else
    first = nil
    second = nil

    nums.reverse.each_with_index do |n, i|
      next if n != last

      if first.nil?
        first = i
      else
        second = i
        break
      end
    end

    nums << second - first
  end

  puts nums.size
end

nums.each_with_index {|n, i| puts "Turn #{i + 1}: #{n}"}
