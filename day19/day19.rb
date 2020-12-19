MAX_RULES = 200

class Rule
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

class AppendRule < Rule
  attr_reader :first, :second, :third

  # @param third my input doesn't actually have a third but the sample does
  def initialize(first, second, third = nil)
    super(:append)
    @first = first
    @second = second
    @third = third
  end

  def to_s
    if third.nil?
      "#{@first} #{@second}"
    else
      "#{@first} #{@second} #{@third}"
    end
  end
end

class OrRule < Rule
  attr_reader :first, :second, :third, :fourth

  def initialize(first, second, third = nil, fourth = nil)
    super(:or)
    @first = first
    @second = second
    @third = third
    @fourth = fourth
  end

  def to_s
    if @third.nil?
      "#{@first} | #{@second}"
    else
      "#{@first} #{@second} | #{@third} #{@fourth}"
    end
  end
end

class RedirectRule < Rule
  attr_reader :rule

  def initialize(rule)
    super(:redirect)
    @rule = rule
  end

  def to_s
    "#{@rule}"
  end
end

class LiteralRule < Rule
  attr_reader :char

  def initialize(char)
    super(:literal)
    @char = char
  end

  def to_s
    "'#{@char}'"
  end
end

def gen_reg(rules, rule_num)
  #puts "Working on #{rule_num}"
  rule = rules[rule_num]
  #puts "#{rules}" if rule.nil?

  case rule.type
  when :append
    if rule.third.nil?
      "(#{gen_reg(rules, rule.first)})(#{gen_reg(rules, rule.second)})"
    else
      "(#{gen_reg(rules, rule.first)})(#{gen_reg(rules, rule.second)})(#{gen_reg(rules, rule.third)})"
    end
  when :or
    if rule.third.nil?
      "(#{gen_reg(rules, rule.first)})|(#{gen_reg(rules, rule.second)})"
    else
      "((#{gen_reg(rules, rule.first)})(#{gen_reg(rules, rule.second)})|(#{gen_reg(rules, rule.third)})(#{gen_reg(rules, rule.fourth)}))"
    end
  when :redirect
    "#{gen_reg(rules, rule.rule)}"
  when :literal
    "#{rule.char}"
  else
    raise "Unknown rule type #{rule.type}!"
  end
end

rule_mode = true
rules = Array.new(MAX_RULES)

inputs = []

File.open('input.txt', 'r').each do |line|
  if line == "\n"
    rule_mode = false
    next
  end

  if rule_mode
    if (m = line.match(/(\d+): (\d+) (\d+)\n/)) # append 2
      rule_num = m[1].to_i
      rule1 = m[2].to_i
      rule2 = m[3].to_i
      rules[rule_num] = AppendRule.new(rule1, rule2)
    elsif (m = line.match(/(\d+): (\d+) (\d+) (\d+)\n/)) # append 3
      rule_num = m[1].to_i
      rule1 = m[2].to_i
      rule2 = m[3].to_i
      rule3 = m[4].to_i
      rules[rule_num] = AppendRule.new(rule1, rule2, rule3)
    elsif (m = line.match(/(\d+): (\d+) \| (\d+)\n/)) # or 2
      rule_num = m[1].to_i
      rule1 = m[2].to_i
      rule2 = m[3].to_i
      rules[rule_num] = OrRule.new(rule1, rule2)
    elsif (m = line.match(/(\d+): (\d+) (\d+) \| (\d+) (\d+)\n/)) # or 4
      rule_num = m[1].to_i
      rule1 = m[2].to_i
      rule2 = m[3].to_i
      rule3 = m[4].to_i
      rule4 = m[5].to_i
      rules[rule_num] = OrRule.new(rule1, rule2, rule3, rule4)
    elsif (m = line.match(/(\d+): (\d+)\n/)) # redirect rule
      rule_num = m[1].to_i
      rule = m[2].to_i
      rules[rule_num] = RedirectRule.new(rule)
    elsif (m = line.match(/(\d+): "(\w)"\n/)) # literal rule
      rule_num = m[1].to_i
      char = m[2]
      rules[rule_num] = LiteralRule.new(char)
    else
      raise "Unknown rule!!!"
    end
  else # we are in the message part of the input
    inputs << line.chomp
  end
end

expr = gen_reg(rules, 0)
puts expr

#puts inputs

# Part 1
matches = inputs.count {|i| i.match?(/^#{expr}$/) }

puts
puts "There are #{matches} matches"

