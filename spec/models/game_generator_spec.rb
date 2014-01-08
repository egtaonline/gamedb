require 'spec_helper'

describe GameGenerator do
  describe '.build' do
    context 'when given an array of roles' do
      let(:roles) do
        [{ player_count: 2, strategy_count: 2 },
         { player_count: 1, strategy_count: 2 }]
      end
      it 'builds the appropriate game' do
        GameGenerator.build(roles)
        Profile.count.should == 6
        SymmetryGroup.count.should == 14
        Player.count.should == 0
      end
      
      context 'and an integer number of observations' do
        let(:observation_count){ 2 }
        it 'builds the correct number of Players as well' do
          GameGenerator.build(roles, observation_count)
          Profile.count.should == 6
          Observation.count.should == 6*observation_count
          SymmetryGroup.count.should == 14
          Profile.all.each do |p|
            sgroup = SymmetryGroup.where(profile_id: p.id).first
            Player.where(symmetry_group_id: sgroup.id).count.should ==
                sgroup.count * observation_count
            sgroup.payoff.should == Player.where(symmetry_group_id: sgroup.id).avg(:payoff)
          end
        end
      end
    end
  end
end