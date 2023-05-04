class SqlViewGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_sql_view
    template 'view_model.erb', "app/models/#{file_name.underscore}.rb"
    template 'migration.erb', "db/migrate/#{migration_file_name}.rb"
  end

  private

  def migration_file_name
    next_migration_number = ActiveRecord::Migration.next_migration_number(1)
    suffix = file_name.underscore

    "#{next_migration_number}_create_view_#{suffix}"
  end
end
