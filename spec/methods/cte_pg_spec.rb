require 'spec_helper'

describe CtePg do
  describe '#time_cached' do
    it 'returns a float number of seconds' do
      GameGenerator.build(
        { 'R1' => { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
          'R2' => { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } }
        })
      method = CtePg.new
      expect(method.time_cached.class).to be(Float)
    end
  end

  describe '#time_uncached' do
    it 'returns a float number of seconds' do
      GameGenerator.build(
        { 'R1' => { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } },
          'R2' => { player_count: 1, strategies: (1..10).map { |i| "S#{i}" } }
        })
      method = CtePg.new
      expect(method.time_uncached.class).to be(Float)
    end
  end
end
