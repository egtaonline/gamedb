require 'spec_helper'

describe SymmetricAggregation do
  describe '.reseed_payoffs' do
    it 'sets a new payoff for each symmetry_group' do
      roles = { 'Role1' => { player_count: 1, strategies: %w(S1) },
                'Role2' => { player_count: 1, strategies: %w(S3) } }
      GameGenerator.build(roles)
      first_agg = SymmetricAggregation.first
      second_agg = SymmetricAggregation.last
      SymmetricAggregation.reseed_payoffs
      new_first_agg = SymmetricAggregation.find(
        symmetric_agg_id: first_agg.symmetric_agg_id)
      new_second_agg = SymmetricAggregation.find(
        symmetric_agg_id: second_agg.symmetric_agg_id)
      expect(first_agg.payoff).to_not eq(new_first_agg.payoff)
      expect(second_agg.payoff).to_not eq(new_second_agg.payoff)
      expect(new_first_agg.payoff).to_not eq(new_second_agg.payoff)
    end
  end
end