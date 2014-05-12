class SubqueryPg
  include AbstractMethod

  QUERY = 'psql -d gamedb -c "SELECT profiles.profile_id FROM ' \
          'symmetric_aggs, (SELECT max(payoff) FROM symmetric_aggs ' \
          'GROUP BY o_agents_profile_id) t, profiles WHERE ' \
          'symmetric_aggs.payoff = t.max AND ' \
          'symmetric_aggs.profile_id = profiles.profile_id ' \
          'GROUP BY profiles.profile_id HAVING COUNT(*) = num_strategies"'

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
