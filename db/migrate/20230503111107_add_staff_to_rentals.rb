class AddStaffToRentals < ActiveRecord::Migration[7.0]
  def change
    add_reference :rentals, :staff, null: false, foreign_key: { to_table: :staff }
  end
end
