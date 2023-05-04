# -*- SkipSchemaAnnotations
# == Schema Information
#
# Table name: customer_list
#
#  id       :bigint
#  address  :string(50)
#  city     :string
#  country  :string
#  name     :text
#  notes    :text
#  phone    :string(20)
#  sid      :bigint
#  zip code :string(10)
#
# SQL View customer_list
class CustomerList < ApplicationRecord
  self.table_name = 'customer_list'
end
