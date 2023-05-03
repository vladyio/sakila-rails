class AddCascadingCustomer < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :customers, :addresses
    add_foreign_key :customers, :addresses, null: false, index: true,
                                            on_delete: :restrict, on_update: :cascade

    remove_foreign_key :customers, :stores
    add_foreign_key :customers, :stores, null: false, index: true,
                                         on_delete: :restrict, on_update: :cascade
  end
end
