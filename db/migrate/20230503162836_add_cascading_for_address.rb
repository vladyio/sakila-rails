class AddCascadingForAddress < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :addresses, :city

    add_foreign_key :addresses, :city, index: true, on_delete: :restrict,
                                       on_update: :cascade
  end
end
