require 'bundler/setup'
require 'sequel'

DB = Sequel.connect('postgres://localhost/gamedb')

require 'gamedb'

a = Time.now
puts a

roles = [{ player_count: 1, strategy_count: 6 },
         { player_count: 1, strategy_count: 6 },
         { player_count: 1, strategy_count: 6 },
         { player_count: 1, strategy_count: 6 },
         { player_count: 1, strategy_count: 6 },
         { player_count: 1, strategy_count: 6 },
         { player_count: 1, strategy_count: 6 }
         ]
GameGenerator.build(roles, 1)
puts Time.now - a
