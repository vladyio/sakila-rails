language_values_copy = <<~SQL
  INSERT INTO languages (id, name, updated_at, created_at) VALUES
  (1, 'English',  '2006-02-15 10:02:19', '2006-02-15 10:02:19'),
  (2, 'Italian',  '2006-02-15 10:02:19', '2006-02-15 10:02:19'),
  (3, 'Japanese', '2006-02-15 10:02:19', '2006-02-15 10:02:19'),
  (4, 'Mandarin', '2006-02-15 10:02:19', '2006-02-15 10:02:19'),
  (5, 'French',   '2006-02-15 10:02:19', '2006-02-15 10:02:19'),
  (6, 'German',   '2006-02-15 10:02:19', '2006-02-15 10:02:19')
SQL

ActiveRecord::Base.connection.execute(language_values_copy)
