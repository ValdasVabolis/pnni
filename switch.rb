class Switch
  attr_accessor :neighbors

  def initialize
    @neighbors = []
  end

  def get_neighbors
    puts @neighbors
  end

  def discover(nodes)
    @neighbors << nodes
  end
end