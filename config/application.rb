require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Project2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = "Asia/Ho_Chi_Minh"
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :vi]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.load_defaults 6.0
  end
end
