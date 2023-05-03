class AddCascadingToStore < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :stores, :addresses
    add_foreign_key :stores, :addresses, null: false, index: true, on_delete: :restrict,
                                         on_update: :cascade

    remove_foreign_key :stores, :staff, column: :manager_staff_id
    add_foreign_key :stores, :staff, column: :manager_staff_id,
                                     null: false, index: true, on_delete: :restrict,
                                     on_update: :cascade
  end
end
