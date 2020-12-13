class Form
  attr_reader :answers

  def initialize
    @answers = Array.new(26, false)
  end

  def set_answer(question)
    @answers[question.ord - 'a'.ord] = true
  end
end

groups = []
current_group = []

File.open('input.txt', 'r').each do |line|
  if line == "\n"
    groups << current_group.clone
    current_group = [] # reset
    next
  end

  new_form = Form.new

  line.each_char do |c|
    new_form.set_answer(c) if c =~ /[a-z]/
  end

  current_group << new_form
end

groups << current_group unless current_group.empty? # adds the last group

# Part 1
total_yeses = 0

groups.each do |group|
  questions = Array.new(26, false)

  group.each do |form|
    form.answers.each_with_index do |bool, i|
      questions[i] = true if bool
    end
  end

  questions.each do |bool|
    total_yeses += 1 if bool
  end
end

puts "There were #{total_yeses} yeses (of anyone in a group saying yes)."

# Part 2
total_strong_yes = 0

groups.each do |group|
  questions = Array.new(26, 0)

  group.each do |form|
    form.answers.each_with_index do |bool, i|
      questions[i] += 1 if bool
    end
  end

  questions.each do |i|
    total_strong_yes += 1 if i == group.length
  end
end

puts "There were #{total_strong_yes} yeses (of all members of a group saying yes)."

