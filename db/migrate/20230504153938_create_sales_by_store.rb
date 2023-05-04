class CreateSalesByStore < ActiveRecord::Migration[7.0]
  def change
    create_view :sales_by_store
  end
end
