class CreateFilms < ActiveRecord::Migration[7.0]
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
    end
  end
end
