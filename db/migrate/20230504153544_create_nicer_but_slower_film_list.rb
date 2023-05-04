class CreateNicerButSlowerFilmList < ActiveRecord::Migration[7.0]
  def change
    create_view :nicer_but_slower_film_list
  end
end
