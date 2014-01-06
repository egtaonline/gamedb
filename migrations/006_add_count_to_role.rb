Sequel.migration do
  change do
    add_column :roles, :count, :integer
  end
end