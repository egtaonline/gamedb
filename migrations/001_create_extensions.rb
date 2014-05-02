Sequel.migration do
  up do
    run 'CREATE EXTENSION IF NOT EXISTS intarray'
  end
end
