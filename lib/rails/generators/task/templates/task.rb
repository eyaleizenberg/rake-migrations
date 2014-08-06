# Checklist:
# 1. Re-runnable on production?
# 2. Is there a chance emails will be sent?
# 3. puts ids & logs (progress log)
# 4. Can you update the records with an update all instead of instantizing?
# 5. Are there any callbacks?
# 6. Performance issues?
# 7. Scoping to account

namespace :<%= file_name %> do
<% actions.each do |action| -%>
  desc "TODO"
  task <%= action %>: [:environment] do


    # DO NOT REMOVE THIS PART
    RakeMigration.find_or_create_by_version(__FILE__[/\d+/])
  end

<% end -%>
end
