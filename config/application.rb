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

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # This application renders traditional HTML forms but, because it runs in
    # API-only mode, Rails does not automatically include rails-ujs to attach
    # the CSRF token header for remote forms. When `form_with` generates remote
    # forms (the default), the authenticity token is omitted from the markup
    # which causes login submissions to fail with
    # ActionController::InvalidAuthenticityToken. Force `form_with` to generate
    # local forms so the token is embedded as a hidden field.
    config.action_view.form_with_generates_remote_forms = false


    # Enable cookie-based sessions for the HTML experiences of the application.
    config.session_store :cookie_store, key: "_homason_session", same_site: :lax
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, config.session_options
    config.middleware.use ActionDispatch::Flash
  end
end
