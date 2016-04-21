require_relative '../classes/edge'

describe Edge do
	it "initialize Edge" do
		edge = Edge.new(1, 2, 7)
		expect(edge.distance).to eq(7)
		expect(edge.src).to eq(1)
		expect(edge.tar).to eq(2)
	end

	it "initialize Edge with default distance" do
		edge = Edge.new(1, 2)
		expect(edge.distance).to eq(1)
	end
end