class ObservationGenerator
  def self.build_for(profiles, count)
    ids = profiles.collect{ |profile| profile.id }
    DB[:observations].import([:profile_id], DB[:profiles].join(
        Sequel.lit("generate_series(1,#{count}) as B"), "B <= #{count}").where(id: ids).select(:id))
  end
end