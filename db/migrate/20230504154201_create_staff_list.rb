class CreateStaffList < ActiveRecord::Migration[7.0]
  def change
    create_view :staff_list
  end
end
