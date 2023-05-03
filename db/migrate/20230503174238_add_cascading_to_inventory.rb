class AddCascadingToInventory < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :inventories, :films
    add_foreign_key :inventories, :films, null: false, index: true, on_delete: :restrict,
                                          on_update: :cascade

    remove_foreign_key :inventories, :stores
    add_foreign_key :inventories, :stores, null: false, index: true, on_delete: :restrict,
                                           on_update: :cascade
  end
end
