# == Schema Information
#
# Table name: actors
#
#  id         :bigint           not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_actors_on_first_name  (first_name)
#  index_actors_on_last_name   (last_name)
#
class Actor < ApplicationRecord
  has_many :films, through: :film_actors

  validates :first_name, presence: true
  validates :last_name, presence: true
end
