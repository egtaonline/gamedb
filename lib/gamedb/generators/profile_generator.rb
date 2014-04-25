class ProfileGenerator
  def self.build_profiles(assignments, payoff=false)
    profiles = []
    sgroups = []
    profile_ids = DB.fetch("INSERT INTO profiles (profile_id, role_assignment) VALUES
        #{Array.new(assignments.size, "(DEFAULT, '#{make_role_string(assignments)}')").join(', ')} RETURNING profile_id").all.collect{ |p| p[:profile_id] }
    assignments.zip(profile_ids).each do |assignment_id_pair|
      assignment, id = assignment_id_pair
      num_strategies_in_profile = get_num_strategies_in_profile(assignment)
      assignment.each do |role|
        role_id = role.first[:role_id]
        role.uniq.each do |strategy|
          if payoff
            sgroups << [id, strategy[:role_id], strategy[:strategy_id], role.count(strategy), Random.rand, num_strategies_in_profile, make_partial_profile(assignment, role_id, strategy)]
          else
            sgroups << [id, strategy[:role_id], strategy[:strategy_id], role.count(strategy), num_strategies_in_profile, make_partial_profile(assignment, role_id, strategy)]
          end
        end
      end
    end
    if payoff
      DB[:symmetry_groups].import([:profile_id, :role_id, :strategy_id, :count, :payoff, :num_strategies_in_profile, :partial_profile], sgroups)
    else
      DB[:symmetry_groups].import([:profile_id, :role_id, :strategy_id, :count, :num_strategies_in_profile, :partial_profile], sgroups)
    end
    profile_ids
  end

  private

  def self.make_role_string(assignments)
    assignments.first.collect{|role| "#{role.first[:role_id]}:#{role.size}" }.join(",")
  end

  def self.get_num_strategies_in_profile(assignment)
    assignment.map{ |role| role.uniq.size }.reduce(:+)
  end

  def self.make_partial_profile(assignment, role_id, strategy)
    role_hash = Hash.new{ |hash, key| hash[key] = Hash.new{ |hash, key| hash[key] = 0 } } # duplicating for safety
    assignment.each do |role|
      trole_id = role.first[:role_id]
      role.each do |entry|
        role_hash[trole_id][entry[:strategy_id]] += 1
      end
    end
    role_hash.collect do |role, strategies|
      "#{role}:{#{strategies.collect{ |s, c| "#{s}:#{c}"}.join(",")}}"
    end.join(",")
  end
end