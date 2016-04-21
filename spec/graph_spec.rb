require_relative '../classes/graph'

describe Graph do

	before(:example) do
		@graph = Graph.new
	end

  let(:connect_graph_nodes) do
    @graph.connect_mutually(1, 2, 7)
    @graph.connect_mutually(1, 6, 14)
    @graph.connect_mutually(1, 3, 9)
    @graph.connect_mutually(2, 3, 10)
    @graph.connect_mutually(2, 4, 15)
    @graph.connect_mutually(3, 6, 2)
    @graph.connect_mutually(3, 4, 11)
    @graph.connect_mutually(4, 5, 6)
    @graph.connect_mutually(5, 6, 9)
  end

  let(:add_nodes_to_graph) do
    (1..6).each {|node| @graph.nodes.push node }
  end
  
  describe "#connect" do

  	it "should raise ArgumentError if node not found in graph" do
  		#check for source node
  		expect {@graph.connect(1, 2, 7)}.to raise_error(ArgumentError, "No such node: 1")
  		@graph.nodes.push 1

      #check for target node
  		expect {@graph.connect(1, 2, 7)}.to raise_error(ArgumentError, "No such node: 2")
  	end

  	it "should should connect nodes" do
  		add_nodes_to_graph
  		@graph.connect_mutually 1, 2, 7
  		expect(@graph.edges.length).to eq(2)
  		edge = @graph.edges.first
  		expect(edge.src).to eq(1)
  		expect(edge.tar).to eq(2)
  		expect(edge.distance).to eq(7)

  	end
  end

  describe "#connect_mutually" do
  	it "should raise ArgumentError if node not found in @graph" do
  		
  		expect {@graph.connect_mutually(1, 2, 7)}.to raise_error(ArgumentError, "No such node: 1")
  		@graph.nodes.push 1
  		expect {@graph.connect_mutually(1, 2, 7)}.to raise_error(ArgumentError, "No such node: 2")
  	end

  	it "should should connect nodes" do
  		add_nodes_to_graph
  		@graph.connect_mutually 1, 2, 7
  		expect(@graph.edges.length).to eq(2)
  		edge = @graph.edges.first
  		expect(edge.src).to eq(1)
  		expect(edge.tar).to eq(2)
  		expect(edge.distance).to eq(7)

  	end
  end

  describe "#neighbors" do
  	it "should return adjacent nodes for given node" do

  		add_nodes_to_graph
  		expect(@graph.neighbors(1)).to be_empty
  		@graph.connect_mutually(1, 2, 7)
  		@graph.connect_mutually(1, 6, 14)
  		@graph.connect_mutually(1, 3, 9)
  		expect(@graph.neighbors(1)).to eq([2,6,3])
  	end
  end

  describe "#distance_between" do
  	it "should return nil for unconnected nodes" do

  		add_nodes_to_graph
  		expect(@graph.distance_between(1,2)).to be_nil
  	end

  	it "should return distance between connected nodes" do

  		add_nodes_to_graph
  		@graph.connect_mutually(1, 2, 7)
  		expect(@graph.distance_between(1,2)).to eq(7)
  	end
  end

  describe "#dijkstra" do
  	it "should return nil for undirected @graph" do

  		add_nodes_to_graph
  		expect(@graph.dijkstra(1,5)).to be_nil
  	end
  	it "should return nil if target is unreachable" do

  		add_nodes_to_graph
  		connect_graph_nodes
  		expect(@graph.dijkstra(1,7)).to be_nil

  	end

  	it "should return nil if source is unreachable" do

  		add_nodes_to_graph
  		connect_graph_nodes
  		expect(@graph.dijkstra(7,5)).to be_nil
  	end

  	it "should return shotest path from source to target" do

  		add_nodes_to_graph
  		connect_graph_nodes
  		expect(@graph.dijkstra(1,5)).to eq(20)
  	end

  	# def connect_graph_nodes
  	# 	@graph.connect_mutually(1, 2, 7)
  	# 	@graph.connect_mutually(1, 6, 14)
  	# 	@graph.connect_mutually(1, 3, 9)
  	# 	@graph.connect_mutually(2, 3, 10)
  	# 	@graph.connect_mutually(2, 4, 15)
  	# 	@graph.connect_mutually(3, 6, 2)
  	# 	@graph.connect_mutually(3, 4, 11)
  	# 	@graph.connect_mutually(4, 5, 6)
  	# 	@graph.connect_mutually(5, 6, 9)
  	# end
  end

  # def add_nodes_to_graph
  # 	(1..6).each {|node| @graph.nodes.push node }
  # end
end