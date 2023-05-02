def seed_file(filename)
  File.join(Rails.root, 'db', 'seeds', "#{filename}.rb")
end

load seed_file('actor')
load seed_file('category')
