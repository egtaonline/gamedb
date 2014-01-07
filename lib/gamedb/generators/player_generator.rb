class PlayerGenerator
  def self.build_for(profile, count)
    DB["INSERT INTO players (symmetry_group_id, payoff) SELECT A.id, random()
    	FROM symmetry_groups as A JOIN generate_series(1,100)
    	AS B on B <= A.count*? WHERE profile_id in ?", count, profile.collect{ |p| p.id }].insert
  end
end