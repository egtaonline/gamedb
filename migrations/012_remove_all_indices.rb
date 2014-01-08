Sequel.migration do
  change do
    drop_index :symmetry_groups, [:profile_id, :role_id, :strategy_id]
    drop_index :observations, :profile_id
    drop_index :players, :symmetry_group_id
  end
end