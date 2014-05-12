class GambitGameWriter
  def self.write(profile_space, env_id, r_partition_id, out='output.nfg')
    f = File.open(out, 'w')
    f.write("NFG 1 R \"TRIAL GAME\"\n")
    role_string = profile_space.keys.map{ |r| "\"#{r}\"" }.join(' ')
    strategy_counts = profile_space.values.map{ |v| v[:strategies].count }
    strategy_string = strategy_counts.join(' ')
    f.write("{ #{role_string} } { #{strategy_string} }\n\n")
    f.close
    system("psql -d gamedb -t -A -c \"
      SELECT array_to_string(array_agg(payoff ORDER BY role_id), ' ')
      FROM symmetric_aggs
      JOIN profiles USING (profile_id)
      JOIN strategies USING (strategy_id)
      WHERE environment_id = #{env_id}
      AND role_partition_id = #{r_partition_id}
      GROUP BY profile_id
      ORDER BY array_agg(strategy_id ORDER BY role_id DESC)\" >> output.nfg")
  end
end
