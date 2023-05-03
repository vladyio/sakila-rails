store_copy_values = <<~SQL
  ALTER TABLE stores DISABLE TRIGGER ALL;

  INSERT INTO stores (id, manager_staff_id, address_id, created_at, updated_at) VALUES
  (1, 1, 1, '2006-02-15 04:57:12', '2006-02-15 04:57:12'),
  (2, 2, 2, '2006-02-15 04:57:12', '2006-02-15 04:57:12');

  ALTER TABLE stores ENABLE TRIGGER ALL;
SQL

ActiveRecord::Base.connection.execute(store_copy_values)
