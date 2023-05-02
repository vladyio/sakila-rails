# == Schema Information
#
# Table name: inventories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  film_id    :bigint           not null
#
# Indexes
#
#  index_inventories_on_film_id  (film_id)
#
# Foreign Keys
#
#  fk_rails_...  (film_id => films.id)
#
class Inventory < ApplicationRecord
  belongs_to :film
end
