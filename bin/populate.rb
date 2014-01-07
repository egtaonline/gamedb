require 'bundler/setup'
require 'sequel'

DB = Sequel.connect('postgres://localhost/gamedb')

require 'gamedb'