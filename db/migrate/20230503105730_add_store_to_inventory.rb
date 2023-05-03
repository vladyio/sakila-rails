class AddStoreToInventory < ActiveRecord::Migration[7.0]
  def change
    add_reference :inventories, :store, null: false, foreign_key: true
  end
end
