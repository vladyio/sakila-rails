class AddStaffToPayments < ActiveRecord::Migration[7.0]
  def change
    add_reference :payments, :staff, null: false, foreign_key: { to_table: :staff }
  end
end
