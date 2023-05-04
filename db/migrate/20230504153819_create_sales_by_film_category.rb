class CreateSalesByFilmCategory < ActiveRecord::Migration[7.0]
  def change
    create_view :sales_by_film_category
  end
end
