class PlayerGenerator
  def self.build_for(profiles, observations)
    ids = profiles.collect{ |profile| profile.id }
    DB["INSERT INTO players (symmetry_group_id, payoff) SELECT A.id, random()
    FROM symmetry_groups as A JOIN generate_series(1,100) as B on B <= A.count*? WHERE
    A.profile_id IN ?", observations, ids].insert
  end
end