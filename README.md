# Sakila database Rails application

Based on a schema from [Learning SQL by Alan Beaulieu](http://shop.oreilly.com/product/9780596007270.do).

## Migration steps:

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

