layout = []

File.open('input.txt', 'r').each do |line|
  row = []

  line.each_char do |c|
    case c
    when 'L'
      row << :empty_seat
    when '.'
      row << :floor
    end
  end

  layout << row
end

#puts layout

def put_layout(layout)
  layout.each do |row|
    row.each do |s|
      case s
      when :empty_seat
        print 'L'
      when :full_seat
        print '#'
      when :floor
        print '.'
      end
    end

    puts
  end
end

# Part 1
def pulse(layout)
  length = layout[0].size - 1
  height = layout.size - 1

  new_layout = []

  layout.each do |row|
    new_layout << row.clone
  end

  layout.each_with_index do |row, i| # i is y
    row.each_with_index do |seat, j| # j is x
      #puts "(#{seat} at #{j}, #{i})"
      neighbors = [
        i != 0 && j != 0 ? layout[i - 1][j - 1] : nil, # top left
        i != 0 ? layout[i - 1][j] : nil, # top
        i != 0 && j != length ? layout[i - 1][j + 1] : nil, # top right
        j != 0 ? layout[i][j - 1] : nil, # left
        j != length ? layout[i][j + 1] : nil, # right
        i != height && j != 0 ? layout[i + 1][j - 1] : nil, # bottom left
        i != height ? layout[i + 1][j] : nil, # bottom
        i != height && j != length ? layout[i + 1][j + 1] : nil # bottom right
      ]

      #puts neighbors

      occ_seats = neighbors.count(:full_seat)
      #puts "I see #{occ_seats} seats used (#{seat} at #{j}, #{i})"

      new_layout[i][j] = :full_seat if seat == :empty_seat && occ_seats == 0
      new_layout[i][j] = :empty_seat if seat == :full_seat && occ_seats >= 4
    end
  end

  new_layout.size.times do |i| # TODO: definitely a better way to do this
    layout[i] = new_layout[i]
  end
end

#put_layout(layout)
#puts
#pulse(layout)
#put_layout(layout)
#puts
#pulse(layout)
#put_layout(layout)

loop do
  last_layout = []

  layout.each do |row|
    last_layout << row.clone
  end

  pulse(layout)

  break if last_layout.eql?(layout)
end

final_occupied_seats = 0

layout.each do |row|
  final_occupied_seats += row.count(:full_seat)
end

puts "There are #{final_occupied_seats} seats occupied at the end."

# Part 2
def get_directed(layout, x, y, x_inc, y_inc)
  length = layout[0].size - 1
  height = layout.size - 1

  return :empty_seat if x == -1 || y == -1

  # TODO
end

def pulse2(layout)
  length = layout[0].size - 1
  height = layout.size - 1

  new_layout = []

  layout.each do |row|
    new_layout << row.clone
  end

  layout.each_with_index do |row, i| # i is y
    row.each_with_index do |seat, j| # j is x
      #puts "(#{seat} at #{j}, #{i})"
      neighbors = [
        i != 0 && j != 0 ? layout[i - 1][j - 1] : nil, # top left
        i != 0 ? layout[i - 1][j] : nil, # top
        i != 0 && j != length ? layout[i - 1][j + 1] : nil, # top right
        j != 0 ? layout[i][j - 1] : nil, # left
        j != length ? layout[i][j + 1] : nil, # right
        i != height && j != 0 ? layout[i + 1][j - 1] : nil, # bottom left
        i != height ? layout[i + 1][j] : nil, # bottom
        i != height && j != length ? layout[i + 1][j + 1] : nil # bottom right
      ]

      #puts neighbors

      occ_seats = neighbors.count(:full_seat)
      #puts "I see #{occ_seats} seats used (#{seat} at #{j}, #{i})"

      new_layout[i][j] = :full_seat if seat == :empty_seat && occ_seats == 0
      new_layout[i][j] = :empty_seat if seat == :full_seat && occ_seats >= 4
    end
  end

  new_layout.size.times do |i| # TODO: definitely a better way to do this
  layout[i] = new_layout[i]
  end
end
