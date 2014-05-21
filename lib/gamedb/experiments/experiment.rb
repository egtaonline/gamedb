class Experiment
  attr_reader :description, :role_count, :strategies_per_role, :player_count,
              :gambit_file

  def initialize(methods, profile_space, description, gambit_file)
    @profile_space = profile_space
    @methods = methods
    @description = description
    @role_count = profile_space.keys.size
    strategy_counts = profile_space.map do |k, v|
      v[:strategies].count
    end
    @strategies_per_role = strategy_counts.reduce(:+).to_f / @role_count
    @player_count = profile_space.map { |k, v| v[:player_count] }.reduce(:+)
    @gambit_file = gambit_file
  end

  def run_cached_trials(iterations)
    reset
    iterations.times do
      SymmetricAggregation.reseed_payoffs
      system("psql -d #{DB_NAME} -c \"VACUUM FULL ANALYZE\"")
      GambitGameWriter.write(@profile_space, @gambit_file, *@game_keys)
      @methods.each do |method|
        time = method.time_cached
        Trial.create(run_at: Time.now, method: method.to_s,
                     role_count: @role_count,
                     strategies_per_role: @strategies_per_role,
                     duration: time,
                     comments: @description + '; cached')
      end
    end
  end

  def reset
    puts 'called'
    DB.run("TRUNCATE TABLE roles CASCADE")
    DB.run("TRUNCATE TABLE role_partitions CASCADE")
    DB.run("TRUNCATE TABLE o_agents_profiles CASCADE")
    DB.run("TRUNCATE TABLE profiles CASCADE")
    DB.run("TRUNCATE TABLE symmetric_aggs CASCADE")
    DB.run("TRUNCATE TABLE strategies CASCADE")
    @game_keys = GameGenerator.build(@profile_space)
  end

  def run_uncached_trials(iterations)
    reset
    iterations.times do
      SymmetricAggregation.reseed_payoffs
      system("psql -d #{DB_NAME} -c \"VACUUM FULL ANALYZE\"")
      GambitGameWriter.write(@profile_space, @gambit_file, *@game_keys)
      @methods.each do |method|
        time = method.time_uncached
        Trial.create(run_at: Time.now, method: method.to_s,
                     role_count: @role_count,
                     strategies_per_role: @strategies_per_role,
                     duration: time,
                     comments: @description + '; uncached')
      end
    end
  end
end
