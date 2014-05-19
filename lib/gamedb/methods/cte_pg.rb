class CtePg < AbstractPg
  def query
    "psql -d #{DB_NAME} -c \"WITH best_response_payoffs AS " \
    '(SELECT o_agents_profile_id, MAX(payoff) AS payoff FROM ' \
    'symmetric_aggs GROUP BY o_agents_profile_id) SELECT profile_id' \
    ' FROM best_response_payoffs INNER JOIN symmetric_aggs USING' \
    ' (o_agents_profile_id, payoff) GROUP BY profile_id, ' \
    'num_strategies HAVING COUNT(*) = num_strategies"'
  end
end
