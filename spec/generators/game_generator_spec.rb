require 'spec_helper'

describe GameGenerator do
  describe '.build' do
    context 'when given an array of roles' do
      let(:roles) do
        [{ name: 'Role1', player_count: 2, strategy_count: 2 },
         { name: 'Role2', player_count: 1, strategy_count: 2 }]
      end
      it 'builds the appropriate game' do
        GameGenerator.build(roles)
        expect(Profile.count).to be(6)
        expect(SymmetricAggregation.count).to be(14)
        expect(SymmetricAggregation.first.payoff.nil?).to be(false)
      end
    end
  end
end
