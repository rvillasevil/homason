require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Homason
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # The UI is rendered server-side, so we need the full middleware stack that
    # includes cookies, flash, sessions and other browser-oriented features.
    config.api_only = false

    # `form_with` generates remote (XHR) forms by default which require the CSRF
    # token to be embedded in the markup because Rails UJS is not part of the
    # asset pipeline in this project. Disabling remote forms globally keeps
    # submissions as classic HTML posts and guarantees the token field is
    # present even when developers forget to pass `local: true`.
    config.action_view.form_with_generates_remote_forms = false
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
