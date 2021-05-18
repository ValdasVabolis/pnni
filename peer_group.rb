class PeerGroup
  attr_accessor :nodes

  def initialize(links = nil)
    @nodes = []
    @id_counter = 0
    @links = links
  end

  def add(node)
    # Each switch must have info for each switch in the network
    node.discover(@nodes)
    # Each switch must flood out its own info to all other switches
    learn_about(node)
    @nodes << node
  end

  def get_all
    @nodes.each { |n| puts n.info }
  end

  def get_by_id(id)
    @nodes.select { |node| node.id == id }.first
  end

  def first_node
    @nodes.first
  end

  def last_node
    @nodes.last
  end


  private

  def learn_about(node)
    @nodes.each do |n|
      n.other_nodes << node
    end
  end
end