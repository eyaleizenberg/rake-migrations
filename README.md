Rake Migrations
===============

This gem helps you and your team members keep track of 'run once' rake tasks.

## Requirements
At the moment I have only tested this on Rails 3.2.X running mysql2 on Mac OS X.
If you can help by testing this on different versions, databases and platforms, let me know.

## Installation
1. Add this this to your gemfile:
```ruby
gem 'pry-byebug'
```

2. Run:
```ruby
bundle install
rails g rake_migrations:install
rake db:migrate
```

## Use
Whenever somebody from your team wants to create a new run once task, simply generate it by running:

```ruby
rails g task <namespace> <task>
rails g task users:update_some_field
```

For example:

```ruby
rails g task users:update_some_field
```

This will generate a file under 'lib/tasks/rake_migrations' with a timestamp and the following content:

```ruby
# Checklist:
# 1. Re-runnable on production
# 2. Is there a chance emails will be sent?
# 3. puts ids & logs (progress log)
# 4. Can you update the records with an update all instead of instantizing?
# 5. Are there any callbacks?
# 6. Performance
# 7. Scoping to account

namespace :users do
  desc "update run_at field to get value as in start_time"
  task update_some_field: [:environment] do

    # DO NOT REMOVE THIS PART
    RakeMigration.find_or_create_by_version(__FILE__[/\d+/])
  end
end
```

Simply insert your code above the "DO NOT REMOVE THIS PART" line. Afterwards you can run the rake task normally:

```ruby
rake users:update_some_field
```

Commit your new file into your repository.

Afterwards, through the magic of git-hooks, whenever someone pulls this branch (or if it's already merged into the master branch), he will see a message in the terminal telling him which rakes need to be run:

```ruby
You need to run the following rakes:
------------------------------------
rake users:update_some_field
```

This project rocks and uses MIT-LICENSE.