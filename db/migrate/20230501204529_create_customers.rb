class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name, null: false, limit: 45
      t.string :last_name, null: false, limit: 45
      t.string :email, limit: 50
      t.references :address, null: false, foreign_key: true
      t.integer :active

      t.timestamps
    end
  end
end
