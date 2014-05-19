class SubqueryPg < AbstractPg
  def query
    "psql -d #{DB_NAME} -c \"SELECT profile_id FROM " \
    'symmetric_aggs, (SELECT o_agents_profile_id, max(payoff) FROM ' \
    'symmetric_aggs GROUP BY o_agents_profile_id) t WHERE ' \
    'symmetric_aggs.o_agents_profile_id = t.o_agents_profile_id AND ' \
    'symmetric_aggs.payoff = t.max ' \
    'GROUP BY profile_id, num_strategies HAVING COUNT(*) = num_strategies"'
  end
end
