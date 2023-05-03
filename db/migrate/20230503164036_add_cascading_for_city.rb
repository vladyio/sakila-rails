class AddCascadingForCity < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :cities, :country

    add_foreign_key :cities, :country, null: false, index: true,
                                       on_delete: :restrict, on_update: :cascade
  end
end
