class ProfileGenerator
  def self.build_profiles(assignments)
    profiles = []
    sgroups = []
    assignments.each do |assignment|
      profile = Profile.new
      profile.save
      profiles << profile
      assignment.each do |role|
        role.uniq.each do |strategy|
          sgroups << [profile.id, strategy.role_id, strategy.id, role.count(strategy)]
        end
      end
    end
    DB[:symmetry_groups].import([:profile_id, :role_id, :strategy_id, :count], sgroups)
    profiles
  end
end