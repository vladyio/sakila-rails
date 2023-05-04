class CreateFunctionGroupConcatFx < ActiveRecord::Migration[7.0]
  def up
    create_function :_group_concat
  end

  def down
    execute('DROP AGGREGATE IF EXISTS group_concat(text);')

    drop_function :_group_concat
  end
end
