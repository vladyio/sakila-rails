class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.timestamp :rental_date, null: false
      t.references :inventory, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.timestamp :return_date

      t.timestamps
    end
  end
end
