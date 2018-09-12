require 'mysql2'
require 'rake_migrations'

module RakeMigrationsCheck
  def self.check
    client = Mysql2::Client.new(host: "localhost", username: "<username>", database: "<database name>")
    results = client.query("select * from rake_migrations").map {|res| res["version"] }
    rake_migrations_lib = "#{`pwd`.strip}/lib/tasks/rake_migrations/*"

    rake_files = Dir[rake_migrations_lib].sort.map do |file|
      rake_id = RakeMigration.version_from_path(file)
      if !results.include?(rake_id)
        file = File.read(file)
        namespace = file[/namespace :?([^: ,]*)/m, 1].strip
        task = file[/task :?([^ :,]*)/m, 1]
        "rake #{namespace}:#{task} # #{rake_id}"
      end
    end.compact

    if !rake_files.empty?
      puts "\n"
      puts "You need to run the following rakes:"
      puts "------------------------------------"
      rake_files.each { |file| puts "\e[31m#{file}\e[0m" }
      puts "\n"
    end
  end
end

RakeMigrationsCheck.check
