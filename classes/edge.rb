class Edge
  attr_accessor :src, :tar, :distance
  
  def initialize(src, tar, distance = 1)
    @src = src
    @tar = tar
    @distance = distance
  end
end