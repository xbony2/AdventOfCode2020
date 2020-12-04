valid_passwords = 0

passwords = []
password_itr = {}

File.open('input.txt', 'r').each do |line|
  if line == "\n"
    passwords << password_itr.clone
    password_itr = {} # restart
    next
  end

  line.scan(/\w+:[#\w\d]+/).each do |field|
    m = field.match(/^(\w+):([#\w\d]+)$/)

    attr = m[1]
    value = m[2]

    password_itr[attr] = value
  end
end

# adds the last one (there is no new line after it)
passwords << password_itr

passwords.each do |p|
  valid_passwords += 1 unless p['byr'].nil? or p['iyr'].nil? or p['eyr'].nil? or p['hgt'].nil? or p['hcl'].nil? or p['ecl'].nil? or p['pid'].nil?
end

puts "There are #{valid_passwords} valid passwords."

very_valid_passwords = 0

passwords.each do |p|
  byr = !p['byr'].nil? && /^\d{4}$/.match?(p['byr']) && p['byr'].to_i >= 1920 && p['byr'].to_i <= 2002
  iyr = !p['iyr'].nil? && /^\d{4}$/.match?(p['iyr']) && p['iyr'].to_i >= 2010 && p['iyr'].to_i <= 2020
  eyr = !p['eyr'].nil? && /^\d{4}$/.match?(p['eyr']) && p['eyr'].to_i >= 2020 && p['eyr'].to_i <= 2030

  next if p['hgt'].nil?
  m = /^(\d{2,3})(cm|in)$/.match(p['hgt'])
  next if m.nil?

  hgt = (m[2] == "cm" && m[1].to_i >= 150 && m[1].to_i <= 193) ^ (m[2] == "in" && m[1].to_i >= 59 && m[1].to_i <= 76)

  hcl = !p['hcl'].nil? && /^#[\d|a-f]{6}$/.match?(p['hcl'])
  ecl = !p['ecl'].nil? && /^(amb|blu|brn|gry|grn|hzl|oth)$/.match?(p['ecl'])
  pid = !p['pid'].nil? && /^\d{9}$/.match?(p['pid'])

  very_valid_passwords += 1 if byr && iyr && eyr && hgt && hcl && ecl && pid
end

puts "There are #{very_valid_passwords} very valid passwords."
