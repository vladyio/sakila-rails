class AddCascadingToRental < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :rentals, :customers
    add_foreign_key :rentals, :customers, null: false, index: true, on_delete: :restrict,
                                          on_update: :cascade

    remove_foreign_key :rentals, :inventories
    add_foreign_key :rentals, :inventories, null: false, index: true, on_delete: :restrict,
                                            on_update: :cascade

    remove_foreign_key :rentals, :staff
    add_foreign_key :rentals, :staff, null: false, index: true, on_delete: :restrict,
                                      on_update: :cascade
  end
end
