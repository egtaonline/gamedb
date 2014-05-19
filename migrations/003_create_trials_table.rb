Sequel.migration do
  change do
    create_table(:trials) do
      primary_key :trial_id
      DateTime :run_at, null: false
      String :method, null: false
      Integer :role_count, null: false
      Integer :strategies_per_role, null: false
      Float :duration, null: false
      String :comments
    end
  end
end
