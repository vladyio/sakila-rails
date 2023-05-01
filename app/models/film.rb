# == Schema Information
#
# Table name: films
#
#  id               :bigint           not null, primary key
#  description      :text
#  length           :integer
#  rantal_rate      :decimal(4, 2)    not null
#  rating           :enum             default("G")
#  release_year     :date
#  rental_duration  :integer          not null
#  replacement_cost :decimal(5, 2)    not null
#  special_features :string           is an Array
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  language_id      :bigint
#
# Indexes
#
#  index_films_on_language_id  (language_id)
#
# Foreign Keys
#
#  fk_rails_...  (language_id => languages.id)
#
class Film < ApplicationRecord
  has_one :language
  has_many :categories, through: :film_categories
  has_many :actors, through: :film_actors

  validates :rental_rate, :rental_duration, :replacement_cost,
            :title, :language_id, presence: true
end
