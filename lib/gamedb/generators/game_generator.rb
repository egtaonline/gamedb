class GameGenerator
  def self.build(roles)
    DB.transaction do
      assignment_generator = AssignmentGenerator.new(roles)
      assignments = assignment_generator.build_assignments
      oa_assignments = assignment_generator.build_other_agents_assignments
      rp_keys = roles.map do |k, v|
        "#{k}:#{v[:player_count]}"
      end
      rp_id = RolePartition
        .find_or_create(role_partition: rp_keys.sort.join(','))
        .role_partition_id
      env_id = Environment.find_or_create(details: 'Default').environment_id
      ProfileGenerator
        .build_profiles(env_id, rp_id, assignments, oa_assignments)
      return [env_id, rp_id]
    end
    [nil, nil]
  end
end
