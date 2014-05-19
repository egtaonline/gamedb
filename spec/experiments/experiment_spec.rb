require 'spec_helper'

describe Experiment do
  describe '.new' do
    it 'tries to build expected game and sets variables appropriately' do
      profile_space = { 'R1' => { player_count: 1, strategies: %w(S1 S2) },
                        'R2' => { player_count: 2, strategies: %w(S3 S4) } }
      methods = []
      description = 'Test'

      experiment = Experiment.new(methods, profile_space, description,
                                  'fake/path')
      expect(experiment.description).to eq(description)
      expect(experiment.role_count).to eq(2)
      expect(experiment.strategies_per_role).to eq(2)
      expect(experiment.player_count).to eq(3)
      expect(experiment.gambit_file).to eq('fake/path')
    end
  end
end
