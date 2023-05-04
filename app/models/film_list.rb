# -*- SkipSchemaAnnotations
# == Schema Information
#
# Table name: film_list
#
#  actors      :text
#  category    :string
#  description :text
#  fid         :bigint
#  length      :integer
#  price       :decimal(4, 2)
#  rating      :enum
#  title       :string
#
# SQL View film_list
class FilmList < ApplicationRecord
  self.table_name = 'film_list'
end
