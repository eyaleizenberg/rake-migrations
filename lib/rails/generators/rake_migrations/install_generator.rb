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
      template("rake_migrations_check.rb", "config/rake_migrations_check.rb")
      template("rake_migration.rb", "models/rake_migration.rb")
      write_to_post_merge_hook
    end

    def write_to_post_merge_hook
      post_merge_file = ".git/hooks/post-merge"
      what_to_write = <<-TEXT
#{!File.exists?(post_merge_file) ? '#!/bin/sh' : ''}
ruby ./config/rake_migrations_check.rb
TEXT

      File.open(post_merge_file, 'a+') do |file|
        file.write(what_to_write) unless file.read.match(/rake_migrations_check/)
      end
      `chmod 777 #{post_merge_file}`
    end
  end
end