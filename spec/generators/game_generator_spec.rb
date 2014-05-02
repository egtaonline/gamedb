require 'spec_helper'

describe GameGenerator do
  describe '.build' do
    context 'when given an array of roles' do
      let(:roles) do
        { 'Role1' => { player_count: 2, strategies: %w(S1 S2) },
          'Role2' => { player_count: 1, strategies: %w(S3 S4) } }
      end
      it 'builds the appropriate game' do
        GameGenerator.build(roles)
        expect(Profile.count).to be(6)
        expect(SymmetricAggregation.count).to be(14)
        target = SymmetricAggregation.first
        expect(target.payoff.nil?).to be(false)
        oa_profile = OtherAgentsProfile.find(
          o_agents_profile_id: target.o_agents_profile_id)[:o_agents_profile]
        assignment = Profile.find(profile_id: target.profile_id)[:assignment]
        s_array = oa_profile.delete('{}').split(',') +
          [target.strategy_id.to_s]
        expect(s_array.sort).to eq(assignment.delete('{}').split(','))
      end
    end
  end
end
