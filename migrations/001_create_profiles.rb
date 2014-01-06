Sequel.migration do
  up do
    create_table(:profiles) do
      primary_key :id
    end
  end
  
  down do
    drop_table(:profiles)
  end
end