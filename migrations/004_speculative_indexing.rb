Sequel.migration do
  up do
    run 'CREATE INDEX oa_profile_payoff_key ON symmetric_aggs
         (o_agents_profile_id ASC, payoff DESC)'
  end
  down do
    run 'DROP INDEX oa_profile_payoff_key'
  end
end
