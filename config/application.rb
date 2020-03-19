require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GitStory
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # For deployment of with Rails 3.2 only
    config.assets.initialize_on_precompile = false

    # For vendor/assets folder
    config.assets.enabled = true
    config.assets.paths << Rails.root.join("vendor", "assets", "javascripts", "bootstrap-4.3.1.min")
    config.assets.paths << Rails.root.join("vendor", "assets", "javascripts", "jquery-3.4.1.min")
    config.assets.paths << Rails.root.join("vendor", "assets", "javascripts", "popper-1.14.7.min")
    config.assets.paths << Rails.root.join("vendor", "assets", "stylesheets", "bootstrap-4.3.1.min")

    # For images
    config.assets.paths << Rails.root.join("app", "assets", "images", "git_story_logo")
    config.assets.paths << Rails.root.join("app", "assets", "images", "git_story_logo_new")
    config.assets.paths << Rails.root.join("app", "assets", "images", "git_story_logo_inverted")
    config.assets.paths << Rails.root.join("app", "assets", "images", "git_story_logo_inverted_transparent")
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
