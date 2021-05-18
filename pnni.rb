require 'graph'

class PNNI
  attr_accessor :pg
  def initialize(peer_group, links)
    @pg = peer_group
    @links = links
  end

  def trigger_flood
    @pg.nodes.each do |n|
      n.flood_ptse
    end
  end

  def print_route(to = @pg.last_node.id)
    vertices = @links.collect { |link| [link.from, link.to, link.weight] }
    g = Graph.new(vertices)
    src, dest = @pg.first_node.id, to
    path, _dist = g.shortest_path(src, dest)
    puts "Chosen route: "
    path.each { |p| puts "#{@pg.get_by_id(p).info}" }
  end

  def get_route(to = @pg.last_node.id)
    vertices = @links.collect { |link| [link.from, link.to, link.weight] }
    g = Graph.new(vertices)
    src, dest = @pg.first_node.id, to
    path, _dist = g.shortest_path(src, dest)
    path
  end


  def print_link_info
    @links.each do |link|
      switch_f = @pg.get_by_id(link.from)
      switch_t = @pg.get_by_id(link.to)
      puts "#{switch_f.name} has link to #{switch_t.name} with AW #{link.weight}"
    end
  end

  def print_peer_group_info
    @pg.nodes.each do |n|
      puts n.info
    end
  end

  def add_node_to_pg(node)
    @pg.add(node)
  end

  def add_link(link)
    @links << link
  end
end