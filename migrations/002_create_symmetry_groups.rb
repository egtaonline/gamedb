Sequel.migration do
  change do
    create_table(:symmetry_groups) do
      primary_key :id
      foreign_key :profile_id, :profiles
      index :profile_id
      Integer :role
      Integer :strategy
      Integer :count
      index [:role, :strategy, :count], unique: true
    end
  end
end