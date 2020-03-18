# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# Add vendor scripts to precompiling
# Stylesheets
Rails.application.config.assets.precompile += %w( bootstrap-4.3.1.min.css )
# Javascripts
Rails.application.config.assets.precompile += %w( jquery-3.4.1.min.js )
Rails.application.config.assets.precompile += %w( popper-1.14.7.min.js )
Rails.application.config.assets.precompile += %w( bootstrap-4.3.1.min.js )
