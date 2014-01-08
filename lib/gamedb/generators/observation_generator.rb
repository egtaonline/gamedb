class ObservationGenerator
  def self.build_for(profiles, count)
    ids = profiles.collect{ |profile| profile.id }
    DB.fetch("INSERT INTO observations (profile_id) SELECT id FROM profiles JOIN generate_series(1,?) as B
      on B <= ? WHERE id IN ? RETURNING id", count, count, ids).all
  end
end