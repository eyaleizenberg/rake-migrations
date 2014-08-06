require 'mysql2'

client = Mysql2::Client.new(host: "localhost", username: "root", database: "samanage_development")
results = client.query("select * from rake_migrations").map {|res| res["version"] }
rake_migrations_lib = "#{`pwd`.strip}/lib/tasks/rake_migrations/*"

rake_files = Dir[rake_migrations_lib].map do |file|
  if !results.include?(file[/\d+/])
    file = File.read(file)
    namespace = file[/namespace :(.*?)do/m, 1].strip
    task = file[/task (.*?):/m, 1]
    "rake #{namespace}:#{task}"
  end
end.compact

if !rake_files.empty?
  puts "\n"
  puts "You need to run the following rakes:"
  puts "------------------------------------"
  rake_files.each { |file| puts "\e[31m#{file}\e[0m" }
  puts "\n"
end