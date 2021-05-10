class PeerGroup
  attr_accessor :nodes

  def initialize
    @nodes = []
  end

  def add(node)
    node.discover(@nodes)
    learn_about(node)
    @nodes << node
  end

  def get_all
    puts @nodes.size
    @nodes.each { |n| puts n }
  end

  private


  def learn_about(node)
    @nodes.each do |n|
      n.neighbors << n
    end
  end
end