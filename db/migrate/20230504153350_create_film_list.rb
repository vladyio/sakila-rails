class CreateFilmList < ActiveRecord::Migration[7.0]
  def change
    create_view :film_list
  end
end
