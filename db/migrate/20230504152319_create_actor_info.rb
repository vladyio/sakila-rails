class CreateActorInfo < ActiveRecord::Migration[7.0]
  def change
    create_view :actor_info
  end
end
