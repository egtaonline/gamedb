require 'bundler/setup'
require 'sequel'

DB = Sequel.connect('postgres://localhost/gamedb')

require 'gamedb'

a = Time.now
puts a

roles = { 'R1' => { player_count: 1, strategies: (1..4).map { |i| "S#{i}" } },
          'R2' => { player_count: 1, strategies: (1..4).map { |i| "S#{i}" } }
        }
GambitGameWriter.write(roles, 1, 1)

puts Time.now - a
