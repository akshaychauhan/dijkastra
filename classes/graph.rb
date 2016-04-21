require_relative './edge'

class Graph
  attr_reader :edges, :nodes
  
  def initialize
    @edges = []
    @nodes = []
  end
  
  # Connect ser and target with given distance
  def connect(src, tar, distance = 1)
    unless @nodes.include?(src)
      raise ArgumentError, "No such node: #{src}"
    end
    unless @nodes.include?(tar)
      raise ArgumentError, "No such node: #{tar}"
    end
    @edges.push Edge.new(src, tar, distance)
  end
  
  # Mutually connect vertices from both direction with given distance
  def connect_mutually(vertex1, vertex2, distance = 1)
    self.connect vertex1, vertex2, distance
    self.connect vertex2, vertex1, distance
  end

  # Find adjacent vertices for given vertex
  def neighbors(vertex)
    neighbors = []
    @edges.each do |edge|
      neighbors.push edge.tar if edge.src == vertex
    end
    return neighbors.uniq
  end

  # Find the distance between two adjacent node
  def distance_between(src, tar)
    @edges.each do |edge|
      return edge.distance if edge.src == src and edge.tar == tar
    end
    nil
  end

  # Find the shotest path between ars and tar
  def dijkstra(src, tar = nil)
    distances = {}
    @nodes.each do |vertex|
      distances[vertex] = nil
    end
    distances[src] = 0
    vertices = @nodes.clone
    until vertices.empty?
      nearest_vertex = vertices.inject do |a, b|
        next b unless distances[a]
        next a unless distances[b]
        next a if distances[a] < distances[b]
        b
      end
      break unless distances[nearest_vertex]
      if tar and nearest_vertex == tar
        return distances[tar]
      end
      neighbors = self.neighbors(nearest_vertex)
      neighbors.each do |vertex|
        alt = distances[nearest_vertex] + self.distance_between(nearest_vertex, vertex)
        if distances[vertex].nil? or alt < distances[vertex]
          distances[vertex] = alt
        end
      end
      vertices.delete nearest_vertex
    end
    
    return nil
  end
end