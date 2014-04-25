require 'bundler/setup'
require 'sequel'

DB = Sequel.connect('postgres://localhost/gamedb')

require 'gamedb'

a = Time.now
puts a

roles = [{ player_count: 1, strategy_count: 10 },
         { player_count: 1, strategy_count: 10 },
         { player_count: 1, strategy_count: 10 },
         { player_count: 1, strategy_count: 10 },
         { player_count: 1, strategy_count: 10 },
         { player_count: 1, strategy_count: 10 }
         ]
GameGenerator.build(roles)
puts Time.now - a
