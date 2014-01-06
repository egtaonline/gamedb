Sequel.migration do
  change do
    create_table(:players) do
      foreign_key :symmetry_group_id, :symmetry_groups
      index :symmetry_group_id
      Float :payoff
    end
  end
end