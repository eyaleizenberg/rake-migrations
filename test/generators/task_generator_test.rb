require 'test_helper'
require "rails/generators/task/task_generator"

class TaskGeneratorTest < Rails::Generators::TestCase
  tests TaskGenerator
  destination File.expand_path("../../tmp", __FILE__)
  setup :prepare_destination

  test "Assert all files are properly created" do
    run_generator %w(users do_something)
    assert_file "lib/tasks/rake_migrations/users.rake"
  end

end