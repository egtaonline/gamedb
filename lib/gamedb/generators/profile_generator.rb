class ProfileGenerator
  def self.build_profiles(env_id, role_pid, assignments, oa_assignments)
    profile_assignments = DB.fetch(
      "INSERT INTO profiles (environment_id, role_partition_id, assignment,
       num_strategies) VALUES
       #{value_string(env_id, role_pid, assignments)}
       RETURNING profile_id, assignment, num_strategies")
    saggs = []
    profile_assignments.each do |p|
      assignment = p[:assignment].delete('{}').split(',')
      id = p[:profile_id]
      num_strategies = p[:num_strategies]
      assignment.uniq.each do |strategy_id|
        saggs << [id, strategy_id, assignment.count(strategy_id),
          get_oa_profile_id(assignment, oa_assignments, strategy_id),
          num_strategies, Random.rand]
      end
    end
    DB[:symmetric_aggs].import([:profile_id, :strategy_id, :num_players,
                                :o_agents_profile_id, :num_strategies,
                                :payoff], saggs)
  end

  private

  def self.value_string(env_id, role_pid, assignments)
    assignments.map do |a|
      count = a.uniq.count
      assignment = a.join(', ')
      "(#{env_id}, #{role_pid}, '{#{assignment}}', #{count})"
    end.join(', ')
  end

  def self.get_oa_profile_id(assignment, oa_assignments, strategy_id)
    oa_key = assignment.dup
    oa_key.delete_at(assignment.find_index(strategy_id))
    oa_key = "{#{oa_key.join(',')}}"
    oa_assignments[oa_key]
  end
end
