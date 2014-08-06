$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rake_migrations/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rake_migrations"
  s.version     = RakeMigrations::VERSION
  s.authors     = ["Eyal Eizenberg"]
  s.email       = ["iz.eyal@gmail.com"]
  s.homepage    = "http://eyaleizenberg.blogspot.com/"
  s.summary     = "A gem to easily keep track of rake tasks"
  s.description = "This gem creates a rake_migrations table and keeps track of rake tasks similar to migrations."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "mysql2"
end
