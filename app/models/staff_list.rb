# -*- SkipSchemaAnnotations
# == Schema Information
#
# Table name: staff_list
#
#  id       :bigint
#  address  :string(50)
#  city     :string
#  country  :string
#  name     :text
#  phone    :string(20)
#  sid      :bigint
#  zip_code :string(10)
#
# SQL View staff_list
class StaffList < ApplicationRecord
  self.table_name = 'staff_list'
end
