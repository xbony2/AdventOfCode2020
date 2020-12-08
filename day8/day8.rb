class InstructionInstance
  attr_reader :param
  attr_accessor :instruct_name, :has_been_accessed

  def initialize(instruct_name, param)
    @instruct_name = instruct_name
    @param = param
    @has_been_accessed = false
  end
end

$program = []

File.open('input.txt', 'r').each do |line|
  m = /(\w{3}) ((?:\+|-)\d+)/.match(line) # Ignore RubyMine here, the regex is fine.

  instruct = m[1]
  param = m[2].to_i

  $program << InstructionInstance.new(instruct, param)
end

# Part 1
$pc = 0 # program counter
$acc = 0 # accumulator

loop do
  inst = $program[$pc]

  if inst.has_been_accessed
    puts "The acc is #{$acc} once we reach an accessed instruction."
    break
  else
    inst.has_been_accessed = true
  end

  case inst.instruct_name
  when 'acc'
    $acc += inst.param
    $pc += 1
  when 'jmp'
    $pc += inst.param
  when 'nop'
    $pc += 1
  else
    puts "Unrecognized instruction '#{inst.instruct_name}'"
  end
end

# Part 2
program_copy = $program.clone

max_calls = 100_000 # if it hits this many calls, we consider it an infinite loop

program_copy.each_with_index do |inst, i|
  next if inst.instruct_name == 'acc' # not corrupted

  $pc = 0
  $acc = 0

  $program[i].instruct_name = inst.instruct_name == 'nop' ? 'jmp' : 'nop'

  calls = 0

  # Execute
  loop do
    inst2 = $program[$pc]

    if inst2.nil? # We are not an infinite loop!
      puts "We changed line #{i} to #{$program[i].instruct_name} and it fixed the infinite loop! The value of the acc is #{$acc}"
      break
    end

    calls += 1
    break if calls >= max_calls

    case inst2.instruct_name
    when 'acc'
      $acc += inst2.param
      $pc += 1
    when 'jmp'
      $pc += inst2.param
    when 'nop'
      $pc += 1
    else
      puts "Unrecognized instruction '#{inst2.instruct_name}'"
    end
  end

  # Clean up
  $program[i].instruct_name = inst.instruct_name == 'nop' ? 'jmp' : 'nop'
end

