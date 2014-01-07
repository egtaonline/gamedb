Sequel.migration do
  change do
    create_table(:observations) do
      primary_key :id
      foreign_key :profile_id, :profiles
      index :profile_id
    end
  end
end