class CreateActors < ActiveRecord::Migration[7.0]
  def change
    create_table :actors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end

    add_index :actors, :first_name
    add_index :actors, :last_name
  end
end
