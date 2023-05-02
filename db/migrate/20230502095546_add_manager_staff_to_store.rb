class AddManagerStaffToStore < ActiveRecord::Migration[7.0]
  def change
    add_reference :stores, :manager_staff, index: true, foreign_key: { to_table: :staff }
  end
end
