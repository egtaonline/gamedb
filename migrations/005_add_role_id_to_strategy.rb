Sequel.migration do
  change do
    alter_table :strategies do |t|
      t.add_foreign_key :role_id, :roles, index: true
    end
  end
end