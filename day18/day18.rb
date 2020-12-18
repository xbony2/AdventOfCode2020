require 'basic_queue'

sum = 0

def interpret_line(line)
  parse_expr(tokenize(line), :end)
end

class Token
  attr_reader :type, :value

  def initialize(type, value = nil)
    @type = type
    @value = value
  end

  def to_s
    @value == nil ? "(#{@type})" : "(#{@type}, #{@value})"
  end
end

def tokenize(line)
  ret = BasicQueue::Queue.new

  line.each_char do |c|
    if c == '('
      ret << Token.new(:left_prn)
    elsif c == ')'
      ret << Token.new(:right_prn)
    elsif c == '+'
      ret << Token.new(:plus)
    elsif c == '*'
      ret << Token.new(:times)
    elsif c =~ /^\d$/ # Note we the input is only one digit nums
      ret << Token.new(:num, c.to_i)
    end
  end

  ret << Token.new(:end)

  ret
end

# Grammar:
#   Node ::= ExprNode | NumNode     # Represented by this class
#   ExprNode ::= Node OpNode Node   # Represented by @type = :expr
#   ExprNode ::= :left_prn Node OpNode Node :right_prn
#   OpNode ::= :plus | :times       # Represented by @op when @type = :expr
#   NumNode ::= :num                # Represented by @num when @type = :num
class Node
  def initialize(left, op = nil, right = nil)
    if op == nil
      @type = :num
      @num = left
    else
      @type = :expr
      @left = left
      @op = op
      @right = right
    end
  end

  def to_s
    if @type == :expr
      "(#{@left} #{@op == :plus ? '+' : '*'} #{@right})"
    else
      "#{@num}"
    end
  end
end

def parse_expr(tokens, until_token)
  # Left
  left = nil

  nxt = tokens.peek

  if nxt.type == :left_prn
    tokens.deq # remove (
    left = parse_expr(tokens, :right_prn)
    tokens.deq # remove )
    return left if tokens.peek.type == until_token
  elsif nxt.type == :num
    left = parse_num(tokens)
    return left if tokens.peek.type == until_token
  else
    raise "Unexpected token #{nxt} on left!"
  end

  # Operator
  op = nil

  nxt = tokens.peek

  if nxt.type == :plus || nxt.type == :times
    op = tokens.deq.type
  else
    raise "Unexpected token #{nxt} on op!"
  end

  # Right
  right = nil

  nxt = tokens.peek

  if nxt.type == :left_prn
    tokens.deq # remove (
    right = parse_expr(tokens, :right_prn)
    tokens.deq # remove )

    if tokens.peek.type != until_token
      # TODO: my head hurts
    end
  elsif nxt.type == :num
    right = parse_expr(tokens, until_token)
  else
    raise "Unexpected token #{nxt} on left!"
  end

  ret = Node.new(left, op, right)
end

def parse_num(tokens)
  nxt = tokens.deq # Yeah it's just one digit
  Node.new(nxt.value)
end

File.open('input.txt', 'r').each do |line|
  puts interpret_line(line)
end
