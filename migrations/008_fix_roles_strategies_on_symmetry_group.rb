Sequel.migration do
  change do
    alter_table :symmetry_groups do |t|
      t.drop_index [:profile_id, :role, :strategy]
      t.drop_column :role
      t.drop_column :strategy
      t.add_foreign_key :role_id, :roles
      t.add_foreign_key :strategy_id, :strategies
      t.add_index [:profile_id, :role_id, :strategy_id], unique: true
    end
  end
end