class AssignmentGenerator
  def initialize(role_input)
    @strategy_ids = {}
    @counts = {}
    roles = RoleGenerator.build(role_input.keys)
    roles.each do |role|
      @counts[role[:role_name]] = role_input[role[:role_name]][:player_count]
      strategies = StrategyGenerator
        .build(role[:role_id], role_input[role[:role_name]][:strategies])
      @strategy_ids[role[:role_name]] = strategies.map { |s| s[:strategy_id] }
    end
  end

  def build_assignments
    role_combinations = @strategy_ids.map do |k, v|
      v.repeated_combination(@counts[k]).to_a
    end
    assignments = role_combinations[0].product(*(role_combinations.drop(1)))
    assignments.map do |a|
      a.flatten.sort
    end
  end

  def build_other_agents_assignments
    assignments = []
    @counts.each do |role, count|
      r_combs = @strategy_ids.map do |k, v|
        if k == role
          v.repeated_combination(@counts[k]-1).to_a
        else
          v.repeated_combination(@counts[k]).to_a
        end
      end
      assignments += r_combs[0].product(*(r_combs.drop(1))).map do |a|
        a.flatten.sort
      end
    end
    oa_profile_assignments = DB.fetch(
      "INSERT INTO o_agents_profiles (o_agents_profile) VALUES
       #{assignments.map { |a| "('{#{a.join(', ')}}')" }.join(', ')}
       RETURNING o_agents_profile_id, o_agents_profile").all
    lookup = {}
    oa_profile_assignments.each do |oa|
      lookup[oa[:o_agents_profile]] = oa[:o_agents_profile_id]
    end
    lookup
  end
end
