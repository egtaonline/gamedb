class SubqueryPg
  include AbstractMethod

  QUERY = 'psql -d gamedb -c "SELECT profile_id FROM ' \
          'symmetric_aggs, (SELECT o_agents_profile_id, max(payoff) FROM ' \
          'symmetric_aggs GROUP BY o_agents_profile_id) t WHERE ' \
          'symmetric_aggs.o_agents_profile_id = t.o_agents_profile_id AND ' \
          'symmetric_aggs.payoff = t.max ' \
          'GROUP BY profile_id HAVING COUNT(*) = num_strategies"'

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
