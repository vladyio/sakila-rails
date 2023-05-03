# == Schema Information
#
# Table name: film_categories
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  film_id     :bigint           not null
#
# Indexes
#
#  index_film_categories_on_category_id  (category_id)
#  index_film_categories_on_film_id      (film_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id) ON DELETE => restrict ON UPDATE => cascade
#  fk_rails_...  (film_id => films.id) ON DELETE => restrict ON UPDATE => cascade
#
class FilmCategory < ApplicationRecord
  belongs_to :film
  belongs_to :category

  validates :film, :category, presence: true
end
