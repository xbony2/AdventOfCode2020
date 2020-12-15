AMOUNT = 30000000

nums = Array(Int32).new(AMOUNT)

File.open("input.txt").each_line do |line|
  nums = line.split(',').map {|n| n.to_i}
end

index1 = Hash(Int32, Int32).new # maps second last to index
index2 = Hash(Int32, Int32).new # maps last to index

nums.each_with_index do |n, i|
  index2[n] = i # Assumption: input does not have repeats
end

(AMOUNT - nums.size).times do
  #puts nums
  #puts index1
  #puts index2

  last = nums.last
  i = nums.size

  if !index1.has_key?(last)
    nums << 0
    index1[0] = index2[0]
    index2[0] = i
  else
    first = index1[last]
    second = index2[last]
    val = second - first
    nums << val

    if !index1.has_key?(val)
      if !index2.has_key?(val) # new value completely
        index2[val] = i
      else # only existed once
        index1[val] = index2[val]
        index2[val] = i
      end
    else # both have existed
      index1[val] = index2[val]
      index2[val] = i
    end
  end

  #puts nums.size # printing stuff is pretty slow
end

puts "The number you want is #{nums.last}"
