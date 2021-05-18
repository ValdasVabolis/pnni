require 'json'

class Ptse
  attr_accessor :sender, :nodes

  def initialize(sender, nodes)
  	@sender = sender
  	@nodes = nodes
  end

  def info
  	"#{JSON.pretty_generate(@sender)} \nhas #{nodes.size} nodes"
  end
end