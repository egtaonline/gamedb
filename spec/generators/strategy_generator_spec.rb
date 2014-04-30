require 'spec_helper'

describe StrategyGenerator do
  describe '.build' do
    let(:role_id) { Role.create(role_name: 'All').role_id }
    let(:strategy_names) { %w(S1 S2) }

    it 'builds strategies for the associated roles' do
      strategies = StrategyGenerator.build(role_id, strategy_names)
      expect(Strategy.count).to eq(2)
      expect(Strategy.where(role_id: role_id, strategy_name: 'S1').count)
        .to eq(1)
      expect(Strategy.where(role_id: role_id, strategy_name: 'S2').count)
        .to eq(1)
    end
  end
end
