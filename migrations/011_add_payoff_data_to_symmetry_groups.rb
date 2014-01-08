Sequel.migration do
  change do
    alter_table :symmetry_groups do |t|
      t.add_column :payoff, :float
      t.add_column :payoff_sd, :float
    end
  end
end