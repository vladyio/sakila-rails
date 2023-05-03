# Sakila database Rails application

Based on a simplified schema from a great book [Learning SQL by Alan Beaulieu](http://shop.oreilly.com/product/9780596007270.do) (original database is [Sakila Sample Database](https://dev.mysql.com/doc/sakila/en/))

Postgres-based source for inspiration: [fspacek/docker-postgres-sakila](https://github.com/fspacek/docker-postgres-sakila)

# Motivation

The goal was to create a Rails/Postgres application with a schema based on the [Sakila Sample Database](https://dev.mysql.com/doc/sakila/en/), but (probably) a more simple version of it.

# Setup

1. `bundle install`
2. `rails db:create`
3. `rails db:migrate`
4. `rails db:seed`

# Current status

**ⓘ** **Important**: table names are singualar (`actor`, `store`) in the original database, but
plural in the project (`actors`, `stores`)

**ⓘ** **Important**: primary keys in the original database
look like `actor.actor_id`, and in this project they look like `actor.id`.

**ⓘ** **Important**: tables only have `last_update` field in the original database, but in this project
I use `created_at`/`updated_at`.

## Tables (models):

**ⓘ** **Important**: some `belongs_to` and `has_many`
could be missing due to my inattention, but I'm in process of figuring it out.
(reference: [Sakila Sample Database  /  Structure  /  Tables](https://dev.mysql.com/doc/sakila/en/sakila-structure-tables.html))

| Implemented (all done)|
| ---------------- |
| actors           |
| addresses        |
| categories       |
| cities           |
| countries        |
| customers        |
| film_actors      |
| film_categories  |
| films            |
| inventories      |
| languages        |
| payments         |
| rentals          |
| staff            |
| store            |

## TODO:

- [ ] Views
- [ ] Procedures / functions
- [ ] Triggers (not sure about doing it yet)
- [ ] Check `ON UPDATE` and `ON DELETE` for existence

# Step by step implementation:

1. [Create `Actor`](#create-actor)
2. [Create `Category`](#create-category)
3. [Create `Language`](#create-language)
4. [Create `Film`](#create-film)
5. [Create `FilmActor`](#create-filmactor)
6. [Create `FilmCategory`](#create-filmcategory)
7. [Bind `Films` with `Actors`, `Films` with `Categories`](#bind-films-with-actors-films-with-categories)
8. [Create `Country`](#create-country)
9. [Create `City`](#create-city)
10. [Bind `City` and `Country`](#bind-city-and-country)
11. [Create `Address`](#create-address)
12. [Bind `Address` and `City`](#bind-address-and-city)
13. [Create `Customer`](#create-customer)
14. [Bind `Customer` and `Address`](#bind-customer-and-address)
15. [Create `Inventory`](#create-inventory)
16. [Set `Language`.`name` limit to 20](#set-languagename-limit-to-20)
17. [Create `Rental`](#create-rental)
18. [Create `Payment`](#create-payment)
19. [Bind `Payment` and `Customer`](#bind-payment-and-customer)
20. [Create `Store`](#create-store)
21. [Create `Staff`](#create-staff)
22. [Add `manager_staff` to `Store`](#add-manager_staff-to-store)
23. [Add `original_language_id` to `Film`](#add-original_language_id-to-film)
24. [Rename `original_language_id` and `rental_rate` columns](#rename-original_language_id-and-rental_rate-columns)
25. [Remove uniqueness index from `city`](#remove-uniqueness-index-from-city)
26. [Add `store_id` to `Inventory`](#add-store_id-to-inventory)
27. [Add `staff_id` to `rentas`](#add-staff_id-to-rentas)
28. [Add `staff_id` to `Payments`](#add-staff_id-to-payments)

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

### Create `Inventory`

First, generate: `rails generate model Inventory`

Then in migration:

```ruby
  def change
    create_table :inventories do |t|
      t.references :film, null: false, foreign_key: true

      t.timestamps
    end
```

Then in model:

```ruby
class Inventory < ApplicationRecord
  belongs_to :film
```

### Set `Language`.`name` limit to 20

First, generate: `rails g migration ChangeLanguageNameLengthLimit`

Then in migration:

```ruby
  def change
    change_column :languages, :name, :string, limit: 20
```

In `models/language.rb`:

```diff
class Language < ApplicationRecord
+ validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
```

### Create `Rental`

First, generate: `rails generate model Rental`

Then in migration:

```ruby
  def change
    create_table :rentals do |t|
      t.timestamp :rental_date, null: false
      t.references :inventory, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.timestamp :return_date

      t.timestamps
```

Then in model:

```ruby
class Inventory < ApplicationRecord
  belongs_to :film
```

### Create `Payment`

First, generate: `rails generate model Payment`

Then in migration:

```ruby
  def change
    create_table :payments do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :rental, null: false, foreign_key: true
      t.decimal :amount, precision: 5, scale: 2, null: false
      t.timestamp :payment_date, null: false

      t.timestamps
```

Then in model:

```ruby
class Payment < ApplicationRecord
  belongs_to :customer
  belongs_to :rental

  validates :amount, :payment_date, presence: true
```

### Bind `Payment` and `Customer`

In `models/customer.rb`:

```diff
class Customer < ApplicationRecord
  belongs_to :address
+ has_many :payments
```

### Create `Store`

First, generate: `rails generate model Store`

Then in migration:

```ruby
  def change
    create_table :stores do |t|
      t.references :address, null: false, foreign_key: true

      t.timestamps
```

Then in model:

```ruby
class Store < ApplicationRecord
  belongs_to :address
```

### Create `Staff`

First, generate: `rails generate model Staff`

Then in migration:

```ruby
  def change
    create_table :staff do |t|
      t.string :first_name, null: false, limit: 45
      t.string :last_name, null: false, limit: 45
      t.references :address, null: false, foreign_key: true
      t.string :email, limit: 50
      t.references :store, null: false, foreign_key: true
      t.boolean :active, null: false
      t.string :username, null: false, limit: 16
      t.string :password, limit: 40

      t.timestamps
```

Then in model:

```ruby
class Staff < ApplicationRecord
  self.table_name = 'staff'

  belongs_to :address
  belongs_to :store

  validates :first_name, :last_name, presence: true, length: { maximum: 45 }
  validates :email, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 16 }
  validates :password, length: { maximum: 40 }
```

### Add `manager_staff` to `Store`:

First, generate `rails g migration AddManagerStaffToStore`

Then in migration:

```ruby
class AddManagerStaffToStore < ActiveRecord::Migration[7.0]
  def change
    add_reference :stores, :manager_staff, index: true, foreign_key: { to_table: :staff }
```

In `models/store.rb`:

```diff
class Store < ApplicationRecord
  belongs_to :address
+ has_one :manager_staff, class_name: 'Staff', foreign_key: :manager_staff
```

### Add `original_language_id` to `Film`:

First, generate `rails g migration AddOriginalLanguageIdToFilm`

Then in migration:

```ruby
class AddOriginalLanguageIdToFilm < ActiveRecord::Migration[7.0]
  def change
    add_reference :films, :original_language_id, foreign_key: { to_table: :languages }
```

### Rename `original_language_id` and `rental_rate` columns

I made a couple of typos in `films` table that needed to be fixed:

```ruby
    rename_column :films, :original_language_id_id, :original_language_id
```

```ruby
    rename_column :films, :rantal_rate, :rental_rate
```

### Remove uniqueness index from `city`

Put by mistake, to remove:

```ruby
    remove_index :cities, :city
```

### Bind `Customer` and `Store`

Missed a reference of `store_id` in `customers`:

```ruby
    add_reference :customers, :store, foreign_key: true
```

### Add `store_id` to `Inventory`

```ruby
  def change
    add_reference :inventories, :store, null: false, foreign_key: true
```

### Add `staff_id` to `Rentals`

```ruby
   add_reference :rentals, :staff, null: false, foreign_key: { to_table: :staff }
```

### Add `staff_id` to `Payments`

```ruby
  add_reference :payments, :staff, null: false, foreign_key: { to_table: :staff }
```
