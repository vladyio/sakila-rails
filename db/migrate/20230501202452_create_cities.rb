class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :city
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end

    add_index :cities, :city, unique: true
  end
end
