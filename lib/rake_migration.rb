class RakeMigration < ::ActiveRecord::Base
  def self.version_from_path(path)
    path.split('/').last[/\d+/]
  end

  def self.mark_complete(file)
    rake_id = version_from_path(file)
    if (RakeMigration.respond_to?(:find_or_create_by))
      RakeMigration.find_or_create_by(version: rake_id)
    else
      RakeMigration.find_or_create_by_version(rake_id)
    end
  end
end
