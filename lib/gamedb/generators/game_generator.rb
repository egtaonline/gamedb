class GameGenerator
  def self.build(roles, observations = 0)
    DB.transaction do
      role_combinations = build_roles(roles)
      assignments = role_combinations[0].product(*(role_combinations.drop(1)))
      profiles = build_profiles(assignments)
      if observations > 0
        PlayerGenerator.build_for(profiles, observations)
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
  
  def self.build_profiles(assignments)
    profiles = []
    assignments.each do |assignment|
      profiles << ProfileGenerator.build_profile(assignment)
    end
    profiles
  end
end