# frozen_string_literal: true

# Ensure a secret key base is available during initialization in production.
# Render runs `assets:precompile` in production mode during its build step,
# so the value has to be present even before the app boots on the server.
if Rails.env.production?
  secret_key_base = ENV["SECRET_KEY_BASE"].presence

  if secret_key_base.blank?
    begin
      secret_key_base = Rails.application.credentials.secret_key_base
    rescue ActiveSupport::EncryptedFile::MissingKeyError, KeyError, NoMethodError, ArgumentError
      secret_key_base = nil
    end
  end

  if secret_key_base.present?
    Rails.application.config.secret_key_base = secret_key_base
  else
    raise "Missing secret_key_base: set SECRET_KEY_BASE env var or credentials.secret_key_base"
  end
end