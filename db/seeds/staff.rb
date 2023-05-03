staff_copy_values = <<~SQL
  ALTER TABLE staff DISABLE TRIGGER ALL;

  INSERT INTO staff (id, first_name, last_name, address_id, email, store_id,
                     active, username, password, created_at, updated_at) VALUES
  (1, 'Mike', 'Hillyer', 3, 'Mike.Hillyer@sakilastaff.com', 1, 't', 'Mike',
    '8cb2237d0679ca88db6464eac60da96345513964', '2006-02-15 03:57:16','2006-02-15 03:57:16'),
  (2, 'Jon', 'Stephens', 4, 'Jon.Stephens@sakilastaff.com', 2, 't',
    'Jon', NULL, '2006-02-15 03:57:16', '2006-02-15 03:57:16');

  ALTER TABLE staff DISABLE TRIGGER ALL;
SQL

ActiveRecord::Base.connection.execute(staff_copy_values)
