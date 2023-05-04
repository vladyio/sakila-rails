# -*- SkipSchemaAnnotations
# == Schema Information
#
# Table name: nicer_but_slower_film_list
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
# SQL View nicer_but_slower_film_list
class NicerButSlowerFilmList < ApplicationRecord
  self.table_name = 'nicer_but_slower_film_list'
end
