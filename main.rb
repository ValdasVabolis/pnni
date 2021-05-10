$LOAD_PATH << Dir.pwd

require 'switch'
require 'peer_group'

s = Switch.new
s1 = Switch.new

pg = PeerGroup.new

pg.add(s)
pg.add(s1)
pg.get_all

s.get_neighbors

