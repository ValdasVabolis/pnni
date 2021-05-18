require 'packet'
require 'ptse'

class Switch
  attr_accessor :id, :nsap_addr, :name, :other_nodes, :links

  def initialize(id, name = nil, nsap_addr = nil)
    @id = id
    @name = name
    @nsap_addr = nsap_addr
    @other_nodes = []
  end

  def flood_ptse
    @other_nodes.each { |n| send_ptse(n) }
  end

  def get_other_nodes
    @other_nodes
  end

  def discover(nodes)
    @other_nodes.push(*nodes)
  end

  def info
    "#{@id} #{@name} @ #{@nsap_addr}"
  end

  def info_other_nodes
    puts "I, #{@name}, know about these nodes: "
    @other_nodes.each { |n| puts "\t#{n.name}" }
  end

  def receive(packet)
    puts "#{@id} #{@name} @ #{@nsap_addr} received packet:"
    packet.print_info
  end


  def send_ptse(node)
    ptse = Ptse.new({id: @id, name: @name, address: @nsap_addr}, @other_nodes)
    packet = Packet.new(ptse)
    node.receive(packet)
  end
end