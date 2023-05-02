# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  city       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
#
# Indexes
#
#  index_cities_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
class City < ApplicationRecord
  belongs_to :country
  has_many :addresses

  validates :city, presence: true
end
