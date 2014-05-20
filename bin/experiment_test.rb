require 'bundler/setup'
require 'sequel'

DB_NAME = 'gamedb'
DB = Sequel.connect("postgres://localhost/#{DB_NAME}")

require 'gamedb'

methods = []
prefix = File.dirname(__FILE__)
gambit_file = prefix + '/output.nfg'
methods << CtePg.new
methods << SubqueryPg.new
methods << StockGambit.new(gambit_file)
methods << MyGambit.new(prefix + '/gambit-enumpure', gambit_file)
profile_space = { 'R1' =>
                  { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
                  'R2' =>
                  { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
                  'R3' =>
                  { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
                  'R4' =>
                  { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
                  'R5' =>
                  { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
                  'R6' =>
                  { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } }
                }
experiment = Experiment.new(methods, profile_space, 'Test', gambit_file)
experiment.run_cached_trials(100)
experiment.run_uncached_trials(100)
