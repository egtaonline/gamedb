require 'bundler/setup'
require 'sequel'

DB_NAME = 'gamedb'
DB = Sequel.connect("postgres://localhost/#{DB_NAME}")

require 'gamedb'

a = Time.now
puts a

roles = { 'R1' => { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
          'R2' => { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
          'R3' => { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
          'R4' => { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
          'R5' => { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
          'R6' => { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } }
        }
GambitGameWriter.write(roles, 'output.nfg', 1, 1)

puts Time.now - a
