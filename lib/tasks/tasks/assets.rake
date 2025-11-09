namespace :assets do
  desc "No-op assets precompile task for API-only deployment"
  task precompile: :environment do
    puts "Skipping assets:precompile because this is an API-only app"
  end

  desc "No-op assets clean task for API-only deployment"
  task clean: :environment do
    puts "Skipping assets:clean because this is an API-only app"
  end
end