Rake Migrations
===============
[![GitHub version](https://badge.fury.io/gh/eyaleizenberg%2Frake-migrations.png)](http://badge.fury.io/gh/eyaleizenberg%2Frake-migrations)
[![Build Status](https://travis-ci.org/eyaleizenberg/rake-migrations.svg?branch=master)](https://travis-ci.org/eyaleizenberg/rake-migrations)
[![Code Climate](https://codeclimate.com/github/eyaleizenberg/rake-migrations/badges/gpa.svg)](https://codeclimate.com/github/eyaleizenberg/rake-migrations)

This gem helps you and your team members keep track of 'run once' rake tasks.

## Requirements
At the moment I have only tested this on Rails 3.2.X running mysql (uses mysql2 gem) or postgresql on Mac OS X.
If you can help by testing this on different versions, databases and platforms, let me know.

## Installation
First, add this this to your gemfile:
```ruby
gem 'rake_migrations'
```

Then, run:
```ruby
bundle install

# For mysql
rails g rake_migrations:install

# For postgresql
rails g rake_migrations:install pg

# Don't forget to migrate (both for mysql and pg)
rake db:migrate
```

Finally, open the file 'config/rake_migrations_check.rb' in your project and replace "database name" with your database's name and the "username" with your database's username (remove smaller/greater than symbols):

```ruby
# For mysql2
client = Mysql2::Client.new(host: "localhost", username: "<username>", database: "<database name>")

# For postgresql
client = PG.connect(host: "localhost", user: "<username>", dbname: "<database name>")
```

## Use
Whenever somebody from your team wants to create a new run once task, simply generate it by running:

```ruby
rails g task <namespace> <task>
```

For example:

```ruby
rails g task users update_some_field
```

This will generate a file under 'lib/tasks/rake_migrations' with a timestamp and the following content:

```ruby
# Checklist:
# 1. Re-runnable on production?
# 2. Is there a chance emails will be sent?
# 3. puts ids & logs (progress log)
# 4. Can you update the records with an update all instead of instantizing?
# 5. Are there any callbacks?
# 6. Performance issues?
# 7. Scoping to account

namespace :users do
  desc "update run_at field to get value as in start_time"
  task update_some_field: [:environment] do
    # EXAMPLE 
    User.update_all({role_id: 1}, {role_id: 2})
    
    # DO NOT REMOVE THIS PART
    RakeMigration.find_or_create_by_version(__FILE__[/\d+/])
  end
end
```

Simply insert your code above the "DO NOT REMOVE THIS PART" line. The checklist is there to help you and the person who is code-reviewing your code to think of problems that might occur from your rake task. Afterwards you can run the rake task normally:

```ruby
rake users:update_some_field
```

Commit your new file into your repository.

Afterwards, through the magic of git-hooks, whenever someone pulls this branch (or a branch that has this file in it), he will see a message in the terminal telling him which rakes need to be run:

```ruby
You need to run the following rakes:
------------------------------------
rake users:update_some_field
```

## Issues, suggestions and forks.
Feel free to open issues, send suggestions and fork this repository.

This gem was developed during my work at [Samanage](http://www.samanage.com/).

Thanks and Enjoy! :)
