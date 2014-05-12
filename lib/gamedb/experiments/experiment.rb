class Experiment
  attr_reader :description, :role_count, :strategies_per_role, :player_count,
              :gambit_file

  def initialize(methods, profile_space, description)
    @methods = methods
    @description = description
    @role_count = profile_space.keys.size
    strategy_counts = profile_space.map do |k, v|
      v[:strategies].count
    end
    @strategies_per_role = strategy_counts.reduce(:+).to_f / @role_count
    @player_count = profile_space.map { |k, v| v[:player_count] }.reduce(:+)
    game_keys = GameGenerator.build(profile_space)
    @gambit_file = GambitGameWriter.write(profile_space, *game_keys)
  end

  def run_cached_trials(iterations)
    methods.each do |method|
      iterations.times do
        time = method.time_cached
# Create TRIAL entry here
      end
    end
  end

  def run_uncached_trial

  end
end
