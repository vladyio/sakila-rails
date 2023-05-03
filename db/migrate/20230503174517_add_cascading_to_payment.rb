class AddCascadingToPayment < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :payments, :customers
    add_foreign_key :payments, :customers, null: false, index: true, on_delete: :restrict,
                                           on_update: :cascade

    remove_foreign_key :payments, :rentals
    add_foreign_key :payments, :rentals, index: true, on_delete: :restrict,
                                         on_update: :cascade

    remove_foreign_key :payments, :staff
    add_foreign_key :payments, :staff, null: false, index: true, on_delete: :restrict,
                                       on_update: :cascade
  end
end
