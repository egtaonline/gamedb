Sequel.migration do
  up do
    run 'ALTER TABLE symmetric_aggs ADD COLUMN num_strategies integer'
  end

  down do
    run 'ALTER TABLE symmetric_aggs DROP COLUMN num_strategies'
  end
end
