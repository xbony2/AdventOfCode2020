require 'rgl/adjacency'
require 'rgl/dot'
require 'set'

nums = []

File.open('input.txt', 'r').each do |line|
  nums << line.to_i
end

nums << 0

nums.sort!

graph = RGL::DirectedAdjacencyGraph.new

examined = Set.new

##
# @param index index of array
def add_to_graph(index, array, examined, graph)
  num = array[index]

  3.times do |i|
    new_index = index + i + 1
    n = array[new_index]

    break if n.nil? || n - num > 3
    #puts "#{num}, #{n}"

    graph.add_edge(num, n)
    add_to_graph(new_index, array, examined, graph) unless examined.include?(num)
  end

  examined << num
end

add_to_graph(0, nums, examined, graph)

#graph.write_to_graphic_file('png', 'sample2')

edges_weights = {}

graph.edges.each do |e|
  edges_weights[ [e.source, e.target] ] = 1
end

puts "Edges: #{graph.edges.size}"
puts "Vertices: #{graph.vertices.size}"
puts "Shortest path: #{graph.dijkstra_shortest_path(edges_weights, nums.min, nums.max)}" # For some reason this errors

