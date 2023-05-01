class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :country, null: false

      t.timestamps
    end

    add_index :countries, :country, unique: true
  end
end
