require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module RakeMigrations
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    extend ActiveRecord::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)

    def create_migration_file
      migration_template "migration.rb", "db/migrate/create_rake_migrations_table.rb"
    end
  end
end