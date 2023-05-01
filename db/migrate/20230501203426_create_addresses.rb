class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :address, null: false, limit: 50
      t.string :address2, limit: 50
      t.string :district, null: false, limit: 20
      t.references :city, null: false, foreign_key: true
      t.string :postal_code, limit: 10
      t.string :phone, null: false, limit: 20

      t.timestamps
    end
  end
end
