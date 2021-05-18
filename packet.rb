require 'ptse'
require 'json'

class Packet
  attr_accessor :data

  def initialize(data)
  	@data = data
  end

  def print_info
    puts @data.class == Ptse ? @data.info : JSON.pretty_generate(@data)
  end
end