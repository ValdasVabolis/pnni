$LOAD_PATH << Dir.pwd

require 'switch'
require 'peer_group'
require 'link'
require 'pnni'

SWITCH_DATA_FILE = 'switches.txt'
LINK_DATA_FILE = 'links.txt'

def read_nodes
  pg = PeerGroup.new
  File.foreach(SWITCH_DATA_FILE) do |line|
    data = line.split
    pg.add(Switch.new(data[0].to_i, data[1], data[2]))
  end
  pg
end

def read_links
  links = []
  File.foreach(LINK_DATA_FILE) do |line|
    data = line.split
    links << Link.new(data[0].to_i, data[1].to_i, data[2].to_i)
  end
  links
end


def node_create_process(pnni)
  puts 'New Node Creation'
  print 'Enter ID of new node: '
  id = gets.chomp.to_i
  print 'Enter name of new node: '
  name = gets.chomp
  print 'Enter NSAP of new node: '
  nsap  = gets.chomp
  print 'Enter list of node IDs and AWs to which the device will connect to: '
  gets.chomp.split.collect(&:to_i).each_slice(2) { |l_id, l_aw| pnni.add_link(Link.new(id, l_id, l_aw)) }
  pnni.add_node_to_pg(Switch.new(id, name, nsap))
  puts 'New node created'
end

def node_packet_send_process(pnni)
  puts 'New Packet to Node'
  print 'Enter destination node ID: '
  id = gets.chomp.to_i
  puts 'Getting route to node...'
  path = pnni.get_route(id)
  path.each { |node_id| pnni.pg.get_by_id(node_id).receive(Packet.new({messsage: 'Hello'})) }
end

def print_info
  puts 'Choose an action: '
  puts '1. Display all nodes'
  puts '2. Display all links between nodes'
  puts '3. Find route to node'
  puts '4. Add new node to network'
  puts '5. Flood packets'
  puts '6. Send packet to a node'
  puts '7. End demo'
end

def main
  pnni = PNNI.new(read_nodes, read_links)

  puts 'Welcome to PNNI protocol demonstration!'

  option = 0
  until option > 6
    print_info
    option = gets.chomp.to_i
    case option
    when 1
      pnni.print_peer_group_info
    when 2
      pnni.print_link_info
    when 3
      puts 'Enter ID of node'
      id = gets.chomp.to_i
      pnni.print_route(id)
    when 4
      node_create_process(pnni)
    when 5
      pnni.trigger_flood
    when 6
      node_packet_send_process(pnni)
    else
      puts 'Goodbye!'    
    end
  end
end


main

# TODO: make nodes send their links with PTSE ( add links field to switch.rb )
# TODO: make each node store their packet info in database.txt file
# TODO: refactor graph.rb a little bit to make it more readable