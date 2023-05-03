class AddCascadingToStaff < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :staff, :addresses
    add_foreign_key :staff, :addresses, null: false, index: true, on_delete: :restrict,
                                        on_update: :cascade

    remove_foreign_key :staff, :stores
    add_foreign_key :staff, :stores, index: true, on_delete: :restrict,
                                     on_update: :cascade
  end
end
