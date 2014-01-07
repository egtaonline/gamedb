Sequel.migration do
  change do
    alter_table :players do |t|
      t.add_foreign_key :observation_id, :observations, index: true
    end
  end
end