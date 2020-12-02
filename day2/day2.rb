valid_passwords = 0
valid_updated_passwords = 0

File.open('input.txt', 'r').each do |password|
  m = /(\d+)-(\d+) (\w): (\w+)/.match(password)

  low = m[1]
  high = m[2]
  letter = m[3]
  text = m[4]

  count = text.count(letter)
  valid_passwords += 1 if low.to_i <= count and count <= high.to_i

  let1 = text[low.to_i - 1]
  let2 = text[high.to_i - 1]

  valid_updated_passwords += 1 if (let1 == letter and let2 != letter) or (let1 != letter and let2 == letter)
end

puts "There are #{valid_passwords} valid passwords."
puts "There are #{valid_updated_passwords} updated valid passwords."
