require_relative './classes/graph'

graph = Graph.new
(1..6).each {|node| graph.nodes.push node }

graph.connect_mutually(1, 2, 7)
graph.connect_mutually(1, 6, 14)
graph.connect_mutually(1, 3, 9)
graph.connect_mutually(2, 3, 10)
graph.connect_mutually(2, 4, 15)
graph.connect_mutually(3, 6, 2)
graph.connect_mutually(3, 4, 11)
graph.connect_mutually(4, 5, 6)
graph.connect_mutually(5, 6, 9)

p graph.dijkstra(1, 5)