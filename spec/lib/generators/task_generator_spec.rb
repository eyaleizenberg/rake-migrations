require "generator_spec"
require "rails/generators/task/task_generator"

describe TaskGenerator do
  destination File.expand_path("../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator ["users", "do_something"]
  end

  before(:each) do
    time_to_test = Time.now
    allow(Time).to receive(:now).and_return(time_to_test)
    @timestamp = time_to_test.strftime("%Y%m%d%H%M")
  end

  it "should create a file from the timestamp and namespace" do
    assert_file "lib/tasks/rake_migrations/#{@timestamp}_users.rake"
  end

  it "should have the namespace 'users'" do
    assert_file "lib/tasks/rake_migrations/#{@timestamp}_users.rake", /namespace :users/
  end

  it "should have the task 'do_something'" do
    assert_file "lib/tasks/rake_migrations/#{@timestamp}_users.rake", /task do_something:/
  end

  it "should have the RakeMigration update" do
    assert_file "lib/tasks/rake_migrations/#{@timestamp}_users.rake", /RakeMigration.find_or_create_by_version/
  end
end