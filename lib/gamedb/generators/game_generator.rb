class GameGenerator
  def self.build(roles, observations = 0)
    DB.transaction do
      role_combinations = build_roles(roles)
      assignments = role_combinations[0].product(*(role_combinations.drop(1)))
      if observations > 0
        profile_ids = ProfileGenerator.build_profiles(assignments)
        observations = ObservationGenerator.build_for(profile_ids, observations)
        PlayerGenerator.build_for(observations)
      else
        ProfileGenerator.build_profiles(assignments, true)
      end
    end
  end

  private

  def self.build_roles(roles)
    role_combinations = []
    roles.each do |role|
      strategy_array = RoleGenerator.build_role(role[:strategy_count])
      role_combinations << strategy_array.repeated_combination(role[:player_count]).to_a
    end
    role_combinations
  end
end