# == Schema Information
#
# Table name: actor_info
#
#  id         :bigint
#  film_info  :text
#  first_name :string
#  last_name  :string
#
# SQL View actor_info
class ActorInfo < ApplicationRecord
  self.table_name = 'actor_info'
end
