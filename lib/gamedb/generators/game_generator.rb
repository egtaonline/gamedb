class GameGenerator
  def self.build(roles, observations = 0)
    DB.transaction do
      role_combinations = build_roles(roles)
      assignments = role_combinations[0].product(*(role_combinations.drop(1)))
      puts 'assignments'
      puts Time.now
      profiles = ProfileGenerator.build_profiles(assignments)
      puts 'profiles'
      puts Time.now
      if observations > 0
        observations = ObservationGenerator.build_for(profiles, observations)
        puts 'observations'
        puts Time.now
        PlayerGenerator.build_for(observations)
        puts 'players'
        puts Time.now
      end
    end
  end
  
  private
  
  def self.build_roles(roles)
    role_combinations = []
    roles.each do |role|
      strategy_array = RoleGenerator.build_role(role)
      role_combinations << strategy_array.repeated_combination(role[:player_count]).to_a
    end
    role_combinations
  end
end