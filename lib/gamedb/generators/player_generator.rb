class PlayerGenerator
  def self.build_for(observations)
    oids = observations.collect{ |o| o[:id] }
    DB["INSERT INTO players (symmetry_group_id, observation_id, payoff) SELECT A.sid, A.oid, random()
    	FROM (SELECT symmetry_groups.id as sid, observations.id as oid, count FROM symmetry_groups, observations
    	WHERE symmetry_groups.profile_id = observations.profile_id
    	AND observations.id IN ?) as A JOIN generate_series(1,100)
    	AS B on B <= A.count", oids].insert
    puts 'player creation'
    puts Time.now
    DB["UPDATE symmetry_groups
        SET payoff = A.payoff, payoff_sd = A.payoff_sd
        FROM (SELECT symmetry_group_id, avg(payoff) as payoff, 
              stddev_samp(payoff) as payoff_sd FROM players
              GROUP BY symmetry_group_id) AS A
        WHERE A.symmetry_group_id = symmetry_groups.id AND
        symmetry_groups.profile_id IN (SELECT DISTINCT profile_id FROM observations
          WHERE id IN ?)", oids].update
    puts 'averaging'
    puts Time.now
  end
end