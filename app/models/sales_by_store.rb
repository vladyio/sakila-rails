# -*- SkipSchemaAnnotations
# == Schema Information
#
# Table name: sales_by_store
#
#  manager     :text
#  store       :text
#  total_sales :decimal
#
# SQL View sales_by_store
class SalesByStore < ApplicationRecord
  self.table_name = 'sales_by_store'
end
