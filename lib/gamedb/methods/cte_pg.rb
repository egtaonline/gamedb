class CtePg
  include AbstractMethod

  QUERY = 'psql -d gamedb -c "WITH best_response_payoffs AS ' \
          '(SELECT o_agents_profile_id, MAX(payoff) AS payoff FROM ' \
          'symmetric_aggs GROUP BY o_agents_profile_id) SELECT profile_id' \
          ' FROM best_response_payoffs INNER JOIN symmetric_aggs USING' \
          ' (o_agents_profile_id, payoff) INNER JOIN profiles USING' \
          ' (profile_id) GROUP BY profile_id, num_strategies ' \
          'HAVING COUNT(*) = num_strategies"'

  def initialize(file_name)
    @file_name = file_name
    @cached = false
  end

  def execute
    system("#{QUERY} > subquery_pg_#{Time.now}.out")
  end

  def ensure_cached
    unless @cached
      system(QUERY)
      @cached = true
    end
  end

  def uncache
    @cached = false
    super
  end
end
