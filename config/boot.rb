ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.


env_file = File.expand_path("../.env", __dir__)

if File.exist?(env_file)
  begin
    require "dotenv"
    Dotenv.load(env_file, "#{env_file}.#{ENV.fetch("RAILS_ENV", "development")}")
  rescue LoadError
    warn "[boot] Dotenv gem not available; skipping .env loading"
  end
end
