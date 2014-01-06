class ProfileGenerator
  def self.build_profile(assignment)
    profile = Profile.new
    profile.save
    assignment.each do |role|
      role.uniq.each do |strategy|
        symmetry_group = SymmetryGroup.new
        symmetry_group.profile_id = profile.id
        symmetry_group.role_id = strategy.role_id
        symmetry_group.strategy_id = strategy.id
        symmetry_group.count = role.count(strategy)
        symmetry_group.save
      end
    end
    profile
  end
end