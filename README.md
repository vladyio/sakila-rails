<div align="center">
  <h1>Sakila database + Postgres + Rails application</h1>
</div>

<div align="center">
  🐘 Postgres · 💎 Ruby 3.2 · 🛤 Rails 7
</div>

<hr>

Rails application based on a schema and data of the
[Sakila Sample Database](https://dev.mysql.com/doc/sakila/en/), also used in a great book
[Learning SQL by Alan Beaulieu](http://shop.oreilly.com/product/9780596007270.do)

Postgres-based source for inspiration:
[fspacek/docker-postgres-sakila](https://github.com/fspacek/docker-postgres-sakila)

# Motivation

The goal was to create a Rails/Postgres application with a schema & data from the
[Sakila Sample Database](https://dev.mysql.com/doc/sakila/en/), to practice both
SQL from the book and Rails with ActiveRecord.

# Setup

```sh
bundle install
rails db:create
rails db:migrate
rails db:seed
```

# Important notices

**ⓘ** **Important**: table names are singualar (`actor`, `store`) in the original database, but
plural in the project (`actors`, `stores`)

**ⓘ** **Important**: primary keys in the original database
look like `actor.actor_id`, and in this project they look like `actor.id`.

**ⓘ** **Important**: tables only have `last_update` field in the original database, but in this project
I use `created_at`/`updated_at`.

**ⓘ** **Important**: geospacial columns (like `store.location` in the original database) and binary columns
(like `staff.picture` in the original database) are not implemented, at least yet.

## TODO:

- [ ] Views
  - [x] `actor_info` (`ActorInfo` model)
  - [x] `customer_list` (`CustomerList` model)
  - [x] `film_list` (`FilmList` model)
  - [x] `nicer_but_slower_film_list`
  - [ ] `sales_by_film_category`
  - [ ] `sales_by_store`
  - [ ] `staff_list`
- [ ] Procedures / functions
- [ ] Triggers (not sure about doing it yet)
- [x] Check `ON UPDATE` and `ON DELETE` for existence
- [x] Tables & Rails models

<details>
  <summary>
    <h3>Step by step implementation</h3>
  </summary>

  1. [Create `Actor`](#create-actor)
  2. [Create `Category`](#create-category)
  3. [Create `Language`](#create-language)
  4. [Create `Film`](#create-film)
  5. [Create `FilmActor`](#create-filmactor)
  6. [Create `FilmCategory`](#create-filmcategory)
  7. [Cross-reference `Films` with `Actors`, `Films` with `Categories`](#cross-reference-films-with-actors-films-with-categories)
  8. [Create `Country`](#create-country)
  9. [Create `City`](#create-city)
  10. [Cross-reference `City` and `Country`](#cross-reference-city-and-country)
  11. [Create `Address`](#create-address)
  12. [Cross-reference `Address` and `City`](#cross-reference-address-and-city)
  13. [Create `Customer`](#create-customer)
  14. [Cross-reference `Customer` and `Address`](#cross-reference-customer-and-address)
  15. [Create `Inventory`](#create-inventory)
  16. [Set `Language`.`name` limit to 20](#set-languagename-limit-to-20)
  17. [Create `Rental`](#create-rental)
  18. [Create `Payment`](#create-payment)
  19. [Cross-reference `Payment` and `Customer`](#cross-reference-payment-and-customer)
  20. [Create `Store`](#create-store)
  21. [Create `Staff`](#create-staff)
  22. [Add `manager_staff` to `Store`](#add-manager_staff-to-store)
  23. [Add `original_language_id` to `Film`](#add-original_language_id-to-film)
  24. [Rename `original_language_id` and `rental_rate` columns](#rename-original_language_id-and-rental_rate-columns)
  25. [Remove uniqueness index from `city`](#remove-uniqueness-index-from-city)
  26. [Add `store_id` to `Inventory`](#add-store_id-to-inventory)
  27. [Add `staff_id` to `Rentals`](#add-staff_id-to-rentals)
  28. [Add `staff_id` to `Payments`](#add-staff_id-to-payments)
  29. [Fix `Film <-> Actor` associations in models](#fix-film---actor-associations-in-models)
  30. [Fix `Film <-> Category` associations in models](#fix-film---category-associations-in-models)
  31. [Fix `Film <-> Language` associations in models](#fix-language---film-associations-in-models)
  32. [Fix `Store <-> Staff` associations in models](#fix-store---staff-associations-in-models)
  33. [Cross-reference `Store` and `Customer`](#cross-reference-store-and-customer)
  34. [Cross-reference `Inventory` with `Store` and `Rental`](#cross-reference-inventory-with-store-and-rental)
  35. [Cross-reference `Payment` with `Rental` and `Staff`](#cross-reference-payment-with-rental-and-staff)
  36. [Cross-reference `Rental` with `Customer` and `Staff`](#cross-reference-rental-with-customer-and-staff)
  37. [Reference `Store` in `Address`](#reference-store-in-address)

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

  ### Cross-reference `Films` with `Actors`, `Films` with `Categories`

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

  ### Cross-reference `City` and `Country`

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

  ### Cross-reference `Address` and `City`

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

  ### Cross-reference `Customer` and `Address`

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

  ### Cross-reference `Payment` and `Customer`

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

  ### Cross-reference `Customer` and `Store`

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

  ### Fix `Film <-> Actor` associations in models

  In `models/actor.rb`:

  ```diff
  class Actor < ApplicationRecord
  + has_many :film_actors
    has_many :films, through: :film_actors
  ```

  In `models/film.rb`:

  ```diff
  class Film < ApplicationRecord
    # ...
  + has_many :film_actors
    has_many :actors, through: :film_actors
  ```

  ### Fix `Film <-> Category` associations in models

  In `models/film.rb`:

  ```diff
  + has_many :film_categories
  ```

  In `models/category.rb`:

  ```diff
  + has_many :film_categories
  + has_many :films, through: :film_categories
  ```

  ### Fix `Language <-> Film` associations in models

  In `models/film.rb`:

  ```diff
  - has_one :language
  + belongs_to :language
  ```

  ### Fix `Store <-> Staff` associations in models

  In `models/store.rb`:

  ```diff
  - has_one :manager_staff, class_name: 'Staff', foreign_key: :manager_staff
  + belongs_to :manager_staff, class_name: 'Staff', foreign_key: :manager_staff_id
  + has_many :staff
  ```

  ### Cross-reference `Store` and `Customer`

  In `models/store.rb`:

  ```diff
  + has_many :customers
  ```

  In `models/customer.rb`:

  ```diff
  + belongs_to :store
  ```

  ### Cross-reference `Inventory` with `Store` and `Rental`

  In `models/inventory.rb`:

  ```diff
  +  belongs_to :store
  +  has_many :rentals
  ```

  In `models/store.rb`:

  ```diff
  +  has_many :inventories
  ```

  ### Cross-reference `Payment` with `Rental` and `Staff`

  In `models/rental.rb`:

  ```diff
  + has_many :payments
  ```

  In `models/staff.rb`:

  ```diff
  + has_many :payments
  ```

  In `models/payments`:

  ```diff
  + belongs_to :staff
  ```

  ### Cross-reference `Rental` with `Customer` and `Staff`

  In `models/rental.rb`:

  ```diff
  + belongs_to :staff
  ```

  In `models/customer.rb`:

  ```diff
  + has_many :rentals
  ```

  In `models/staff.rb`:

  ```diff
  + has_many :rentals
  ```

  ### Reference `Store` in `Address`

  In `models/address.rb`:

  ```diff
  + has_one :store
  ```
</details>
