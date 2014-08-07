require "generator_spec"
require "rails/generators/rake_migrations/install_generator"

describe RakeMigrations::InstallGenerator do
  destination File.expand_path("../../tmp", __FILE__)

  context "migration and mysql2" do
    before(:all) do
      prepare_destination
      run_generator
    end

    it "should create a migration" do
      assert_migration "db/migrate/create_rake_migrations_table.rb"
    end

    it "should create the rake_migrations table" do
      assert_migration "db/migrate/create_rake_migrations_table.rb", /create_table :rake_migrations/
    end

    it "should create the version column" do
      assert_migration "db/migrate/create_rake_migrations_table.rb", /t.string :version/
    end

    it "should copy the rake_migrations_check file with mysql2 support" do
      assert_file "config/rake_migrations_check.rb", /Mysql2::Client/
    end
  end

  context "postgresql" do
    before(:all) do
      prepare_destination
      run_generator ["pg"]
    end

    it "should copy the rake_migrations_check file with pg support" do
      assert_file "config/rake_migrations_check.rb", /PG.connect/
    end
  end
end