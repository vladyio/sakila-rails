# -*- SkipSchemaAnnotations
# == Schema Information
#
# Table name: sales_by_film_category
#
#  category    :string
#  total_sales :decimal
#
# SQL View sales_by_film_category
class SalesByFilmCategory < ApplicationRecord
  self.table_name = 'sales_by_film_category'
end
