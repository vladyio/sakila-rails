# Sakila database Rails application

Based on a schema from [Learning SQL by Alan Beaulieu](http://shop.oreilly.com/product/9780596007270.do).

Postgres-based source for inspiration: [fspacek/docker-postgres-sakila](https://github.com/fspacek/docker-postgres-sakila)

## Step by step implementation:

### Create `Actors`

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
    create_table :category do |t|
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

