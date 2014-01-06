Sequel.migration do
  change do
    drop_index :symmetry_groups, [:role, :strategy, :count]
    add_index :symmetry_groups, [:profile_id, :role, :strategy], unique: true
  end
end