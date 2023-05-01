# Sakila database Rails application

Based on a schema from [Learning SQL by Alan Beaulieu](http://shop.oreilly.com/product/9780596007270.do).

Postgres-based source for inspiration: [fspacek/docker-postgres-sakila](https://github.com/fspacek/docker-postgres-sakila)

## Step by step implementation:

### Create `Actor`

First, generate: `rails generate model Actor`

Then in migration:

```ruby
  def change
    create_table :actors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end

    add_index :actors, :first_name
    add_index :actors, :last_name
  end
```

Then in model:

```ruby
class Actor < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
```

### Create `Category`

First, generate: `rails generate model Category`

Then in migration:

```ruby
  def change
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :categories, :name, unique: true
  end
```

Then in model:

```ruby
class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
```

### Create `Language`

First, generate: `rails generate model Language`

Then in migration:

```ruby
  def change
    create_table :languages do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :categories, :name, unique: true
  end
```

Then in model:

```ruby
class Language < ApplicationRecord
  validates :name, presence: true, uniqueness: true
```

### Create `Film`

First, generate: `rails generate model Film`

Then in migration:

```ruby
  def change
    create_enum :rating, %w[G PG PG-13 R NC-17]

    create_table :films do |t|
      t.string :title, null: false
      t.text :description
      t.date :release_year
      t.integer :rental_duration, null: false
      t.decimal :rantal_rate, precision: 4, scale: 2, null: false
      t.integer :length, limit: 3
      t.decimal :replacement_cost, precision: 5, scale: 2, null: false
      t.enum :rating, enum_type: 'rating', default: 'G'
      t.string :special_features, array: true

      t.timestamps
```
Another migration to reference `language_id` in `Film`:

```ruby
class AddLanguageToFilm < ActiveRecord::Migration[7.0]
  def change
    add_reference :films, :language, foreign_key: true
```

Then in `Film` model:

```ruby
class Film < ApplicationRecord
  has_one :language

  validates :rental_rate, :rental_duration, :replacement_cost,
            :title, :language_id, presence: true
```

### Create `FilmActor`

First, generate: `rails generate model FilmActor`

Then in migration:

```ruby
  def change
    create_table :film_actors do |t|
      t.references :film, null: false, foreign_key: true
      t.references :actor, null: false, foreign_key: true

      t.timestamps
```

Then in model:

```ruby
class FilmActor < ApplicationRecord
  belongs_to :film
  belongs_to :actor

  validates :film, :actor, presence: true
```

### Create `FilmCategory`

First, generate: `rails generate model FilmCategory`

Then in migration:

```ruby
  def change
    create_table :film_categories do |t|
      t.references :film, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
```

Then in model:

```ruby
class FilmCategory < ApplicationRecord
  belongs_to :film
  belongs_to :category

  validates :film, :category, presence: true
```

### Bind `Films` with `Actors`, `Films` with `Categories`

In `models/actor.rb`:

```diff
class Actor < ApplicationRecord
+ has_many :films, through: :film_actors

  validates :first_name, presence: true
  validates :last_name, presence: true
end
```

In `models/film.rb`:

```diff
class Film < ApplicationRecord
  has_one :language
+ has_many :categories, through: :film_categories
+ has_many :actors, through: :film_actors

  validates :rental_rate, :rental_duration, :replacement_cost,
            :title, :language_id, presence: true
end
```

### Create `Country`

First, generate: `rails generate model Country`

Then in migration:

```ruby
  def change
    create_table :countries do |t|
      t.string :country, null: false

      t.timestamps
    end

    add_index :countries, :country, unique: true
```

Then in model:

```ruby
class Country < ApplicationRecord
  validates :country, presence: true, uniqueness: true
```

### Create `City`

First, generate: `rails generate model City`

Then in migration:

```ruby
  def change
    create_table :cities do |t|
      t.string :city
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end

    add_index :cities, :city, unique: true
```

Then in model:

```ruby
class City < ApplicationRecord
  belongs_to :country

  validates :city, presence: true, uniqueness: true
```

### Bind `City` and `Country`

In `models/country.rb`:

```diff
class Country < ApplicationRecord
+ has_many :cities

  validates :country, presence: true, uniqueness: true
end
```

### Create `Address`

First, generate: `rails generate model Address`

Then in migration:

```ruby
  def change
    create_table :addresses do |t|
      t.string :address, null: false, limit: 50
      t.string :address2, limit: 50
      t.string :district, null: false, limit: 20
      t.references :city, null: false, foreign_key: true
      t.string :postal_code, limit: 10
      t.string :phone, null: false, limit: 20

      t.timestamps
```

Then in model:

```ruby
class Address < ApplicationRecord
  belongs_to :city

  validates :address, :district, :phone, presence: true
```

### Bind `Address` and `City`

In `models/city.rb`:

```diff
class City < ApplicationRecord
  belongs_to :country
+ has_many :addresses

  validates :city, presence: true, uniqueness: true
```

### Create `Customer`

First, generate: `rails generate model Customer`

Then in migration:

```ruby
  def change
    create_table :customers do |t|
      t.string :first_name, null: false, limit: 45
      t.string :last_name, null: false, limit: 45
      t.string :email, limit: 50
      t.references :address, null: false, foreign_key: true
      t.integer :active

      t.timestamps
```

Then in model:

```ruby
class Customer < ApplicationRecord
  belongs_to :address

  validates :first_name, :last_name, presence: true
  validates :email, length: { maximum: 50 }
```

### Bind `Customer` and `Address`

In `models/address.rb`:

```diff
class Address < ApplicationRecord
  belongs_to :city
+ has_many :customers
```
