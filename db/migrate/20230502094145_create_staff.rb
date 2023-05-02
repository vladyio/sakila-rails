class CreateStaff < ActiveRecord::Migration[7.0]
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
    end
  end
end
