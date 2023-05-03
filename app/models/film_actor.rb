# == Schema Information
#
# Table name: film_actors
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  actor_id   :bigint           not null
#  film_id    :bigint           not null
#
# Indexes
#
#  index_film_actors_on_actor_id  (actor_id)
#  index_film_actors_on_film_id   (film_id)
#
# Foreign Keys
#
#  fk_rails_...  (actor_id => actors.id) ON DELETE => restrict ON UPDATE => cascade
#  fk_rails_...  (film_id => films.id) ON DELETE => restrict ON UPDATE => cascade
#
class FilmActor < ApplicationRecord
  belongs_to :film
  belongs_to :actor

  validates :film, :actor, presence: true
end
