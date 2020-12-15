class Mask
  def initialize(str)
    str.reverse!

    @or_part = 0
    @and_part = 0b11111111111111111111111111111111

    str.size.times do |i|
      @or_part = @or_part | (2 ** i) if str[i] == '1'
      @and_part = @and_part ^ (2 ** i) if str[i] == '0'
    end

    #puts @or_part.to_s(2)
    #puts @and_part.to_s(2)
  end

  def transform(int)
    (int | @or_part) & @and_part # precedence is important here
  end
end

mask = nil
mem = {} # memory location => value

File.open('input.txt', 'r').each do |line|
  if line.start_with? 'mask'
    m = line.match(/mask = ([01X]+)/)
    mask = Mask.new(m[1])
  else
    m = line.match(/mem\[(\d+)\] = (\d+)/)
    mem[m[1].to_i] = mask.transform(m[2].to_i)
  end
end

#puts mem

puts "We want #{mem.values.sum}."
