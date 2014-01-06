Sequel.migration do
  change do
    create_table(:roles) do
      primary_key :id
      String :name
    end
    
    create_table(:strategies) do
      primary_key :id
      String :name
    end
  end
end