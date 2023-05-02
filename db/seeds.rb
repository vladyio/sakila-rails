def seed_file(filename)
  File.join(Rails.root, 'db', 'seeds', "#{filename}.rb")
end

# load seed_file('actor')
# load seed_file('category')
# load seed_file('language')
# load seed_file('film')
# load seed_file('film_actor')
# load seed_file('film_category')
load seed_file('country')
