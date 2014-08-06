class CreateRakeMigrationsTable < ActiveRecord::Migration
  # zibi
  def self.up
    create_table :rake_migrations do |t|
      t.string :version
    end
  end

  def self.down
    drop_table :rake_migrations
  end
end
