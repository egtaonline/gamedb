Sequel.migration do
  change do
    create_table(:roles) do
      primary_key :role_id
      String :role_name, null: false
    end

    create_table(:strategies) do
      primary_key :strategy_id
      foreign_key :role_id, :roles
      String :strategy_name, null: false
      unique [:role_id, :strategy_name]
    end

    create_table(:role_partitions) do
      primary_key :role_partition_id
      String :role_partition, null: false
    end

    create_table(:o_agents_profiles) do
      primary_key :o_agents_profile_id
      column :o_agents_profile, 'integer[]', null: false, unique: true
    end

    create_table(:environments) do
      primary_key :environment_id
      String :details, null: false
    end

    create_table(:profiles) do
      primary_key :profile_id
      foreign_key :environment_id
      foreign_key :role_partition_id
      column :assignment, 'integer[]', null: false
      unique [:environment_id, :assignment]
      Integer :num_strategies, null: false
    end

    create_table(:symmetric_aggs) do
      primary_key :symmetric_agg_id
      foreign_key :profile_id
      foreign_key :o_agents_profile_id
      foreign_key :strategy_id
      Integer :num_players, null: false
      Float :payoff
      unique [:profile_id, :strategy_id]
      unique [:o_agents_profile_id, :strategy_id]
    end
  end
end
