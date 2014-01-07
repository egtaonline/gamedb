lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "gamedb/version"

Gem::Specification.new do |s|
  s.name        = 'gamedb'
  s.version     = GameDb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Support for data-driven game analysis."
  s.description = "Database models and functionality for building and analyzing empirical games."
  s.authors     = ["Ben Cassell"]
  s.email       = 'bcassell@umich.edu'
  s.homepage    = 'http://github.com/egtaonline/gamedb'
  s.license       = 'MIT'
  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md)
  s.test_files   = Dir.glob("spec/**/*")
  s.require_path = 'lib'
  
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pg'
end